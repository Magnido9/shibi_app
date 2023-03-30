import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as External;

class ImageColorSwitcher extends StatefulWidget {
  /// Holds the Image Path
  final String imagePath;

  /// Holds the MaterialColor
  final Color color;
  final Color second;
  final Color main;
  final bool darker;
  final double width, height;
  final int forgive;

  ImageColorSwitcher(
      {required this.imagePath,
      required this.color,
      required this.main,
      required this.second,
      required this.height,
      required this.width,
      this.darker = true,
      this.forgive = 40, Key? key}) : super(key: key);

  @override
  _ImageColorSwitcherState createState() => _ImageColorSwitcherState();
}

class _ImageColorSwitcherState extends State<ImageColorSwitcher> {
  /// Holds the Image in Byte Format
  Future<ImageProvider<Object>>? imageBytes;
  ImageProvider<Object>? oldImage;
  @override
  void initState() {
    imageBytes = switchColor(widget.imagePath);

    super.initState();
  }

  @override
  void didUpdateWidget(ImageColorSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.imagePath != oldWidget.imagePath ||
        widget.color != oldWidget.color) {
      imageBytes = switchColor(widget.imagePath);
    }
  }

  /// A function that switches the image color.
  Future<ImageProvider<Object>> switchColor(String path) async {
    Uint8List bytes =
        (await rootBundle.load(widget.imagePath)).buffer.asUint8List();
    // Decode the bytes to [Image] type
    final image = External.decodeImage(bytes);

    // Convert the [Image] to RGBA formatted pixels
    final pixels = image!.getBytes(order: External.ChannelOrder.rgba);

    // Get the Pixel Length
    final int length = pixels.lengthInBytes;

    for (var i = 0; i < length; i += 4) {
      ///           PIXELS
      /// =============================
      /// | i | i + 1 | i + 2 | i + 3 |
      /// =============================

      // pixels[i] represents Red
      // pixels[i + 1] represents Green
      // pixels[i + 2] represents Blue
      // pixels[i + 3] represents Alpha

      // Detect the light blue color & switch it with the desired color's RGB value.
      if (_range(pixels[i], widget.main.red) &&
          _range(pixels[i + 1], widget.main.green) &&
          _range(pixels[i + 2], widget.main.blue)) {
        pixels[i] = widget.color.red;
        pixels[i + 1] = widget.color.green;
        pixels[i + 2] = widget.color.blue;
      }

      // Detect the darkish blue shade & switch it with the desired color's RGB value.
      else if (_range(pixels[i], widget.second.red) &&
          _range(pixels[i + 1], widget.second.green) &&
          _range(pixels[i + 2], widget.second.blue)) {
        if (widget.darker) {
          pixels[i] = darken(widget.color).red;
          pixels[i + 1] = darken(widget.color).green;
          pixels[i + 2] = darken(widget.color).blue;
        } else {
          pixels[i] = lighten(widget.color).red;
          pixels[i + 1] = lighten(widget.color).green;
          pixels[i + 2] = lighten(widget.color).blue;
        }
      }
    }
    oldImage =
        Image.memory(Uint8List.fromList(External.encodePng(image,level: 1))).image;
    return oldImage!;
  }

  bool _range(int a, int b) {
    return ((a - widget.forgive) <= b && (a + widget.forgive >= b));
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes == null
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.red,
          ))
        : FutureBuilder(
            future: imageBytes,
            builder: (_, AsyncSnapshot<ImageProvider<Object>> snapshot) {
              return snapshot.hasData
                  ? Container(
                      height: widget.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitHeight, image: snapshot.data!)),
                    )
                  : (oldImage != null)
                      ? Container(
                          height: widget.height,
                          width: widget.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight, image: oldImage!)),
                        )
                      : Container(width: 1,height: 1,);
            });
  }
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

//
