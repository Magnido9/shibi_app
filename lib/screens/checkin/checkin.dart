library feelings;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feelings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app',
      home: FeelingPage(),
    );
  }
}

class FeelingPage extends StatefulWidget {
  @override
  _FeelingState createState() => _FeelingState();
}

class _FeelingState extends State<FeelingPage> {
  double feeling = 0;
  Offset offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _sizePainter = Size.square(_width * 0.7);
    return Scaffold(
      appBar: AppBar(title: Text('איך אתה מרגיש יא חתיכת חותך וורידים')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(4),
              child: GestureDetector(
                child: CustomPaint(
                  painter: _FeelingPainter(offset: offset),
                  size: _sizePainter,
                ),
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onPanStart(DragStartDetails event) =>
      setState(() => offset = event.localPosition);

  _onPanUpdate(DragUpdateDetails event) =>
      setState(() => offset = event.localPosition);

  _onPanEnd(DragEndDetails event) async {
    setState(() => {offset = Offset(0, 0)});
  }
}

class _FeelingPainter extends CustomPainter {
  final Offset offset;

  _FeelingPainter({
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;
    double phea = atan((center.dx - offset.dx) / (center.dy - offset.dy));
    phea = (offset.dy > center.dy)
        ? ((offset.dx < center.dx) ? (phea + pi) : (phea - pi))
        : phea;
    double phea_abs = (phea < 0) ? -phea : phea;
    print((phea / pi).toString() + ' pi');
    var painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.alphaBlend(Color(0xff8EB0C3).withOpacity(phea_abs / pi),
          Color(0xffECA5DC).withOpacity(1 - phea_abs / pi))
      ..strokeWidth = 20;
    canvas.drawCircle(center, radius, painter);
    canvas.drawCircle(
        center, radius * 0.8, painter..style = PaintingStyle.fill);
    canvas.drawCircle(center + Offset(-radius * sin(phea), -radius * cos(phea)),
        15, painter..color = Colors.grey);
    canvas.drawCircle(center, radius * 0.3, painter..color = Colors.white);
  }

  @override
  bool shouldRepaint(_FeelingPainter oldDelegate) {
    return offset != oldDelegate.offset;
  }
}
