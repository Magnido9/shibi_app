library authentication;
import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/home.dart';
import 'homescreen.dart';
import 'package:flutter/services.dart';
class Password extends StatelessWidget {
  Password({required this.first});
  bool first;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PasswordPage(title: 'Pattern Lock Screen Flutter', first:first),
    );
  }
}

class PasswordPage extends StatefulWidget {
  PasswordPage({Key? key, required this.title, required this.first}) : super(key: key);

  final String title;
  final bool first;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PasswordPage> {
  Offset offset=Offset(0,0);
  List<int> codes = [];

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _sizePainter = Size.square(_width);
    var button =widget.first ? ElevatedButton(onPressed: _submit, child: Text('submit')) :
                                Container();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(4),

            child: GestureDetector(
              child: CustomPaint(
                painter: _LockScreenPainter(
                    codes: codes, offset: offset, onSelect: _onSelect),
                size: _sizePainter,
              ),
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
            ),
          ),
          button,
          if(widget.first) ElevatedButton(child: Text("CLEAR CODE"), onPressed: _clearCodes)
        ],
      ),
    );
  }

  _onPanStart(DragStartDetails event) => _clearCodes();

  _onPanUpdate(DragUpdateDetails event) =>
      setState(() => offset = event.localPosition);

  _onPanEnd(DragEndDetails event) async {
    setState(() => {offset = Offset(0, 0)});
    await _continue();
    if(!widget.first) _clearCodes();
  }

  _onSelect(int code) {
    if (codes.isEmpty || !codes.contains(code)) {
      codes.add(code);
    }
  }

  _submit()async {
    String? pid = AuthRepository
        .instance()
        .user
        ?.uid;
    await FirebaseFirestore.instance.collection("users").doc(pid).set({
      'password' : codes.join() },SetOptions(merge: true));
    Navigator.push(context, MaterialPageRoute(builder: (context) => Instructions()));

  }
  _continue() async{
    String? pid = AuthRepository
        .instance()
        .user
        ?.uid;
    String n_pass = (await FirebaseFirestore.instance.collection("users").doc(
        pid).get())[ 'password'];
    if(n_pass==(codes.join())){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    else{
      final snackBar = SnackBar(
        content: const Text('Wrong Password'),

      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }


  _clearCodes() => setState(() {
    codes = [];
    offset = Offset(0,0);
  });
}

class _LockScreenPainter extends CustomPainter {
  final int _total = 9;
  final int _col = 3;
  Size size = Size(0, 0);

  final List<int> codes;
  final Offset offset;
  final Function(int code) onSelect;

  _LockScreenPainter({
    required this.codes,
    required this.offset,
    required this.onSelect,
  });

  double get _sizeCode => size.width / _col;

  Paint get _painter =>
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;

    for (var i = 0; i < _total; i++) {
      var _offset = _getOffetByIndex(i);
      var _color = _getColorByIndex(i);

      var _radiusIn = _sizeCode / 2.0 * 0.2;
      _drawCircle(canvas, _offset, _radiusIn, _color, true);

      var _radiusOut = _sizeCode / 2.0 * 0.6;
      _drawCircle(canvas, _offset, _radiusOut, _color);

      var _pathGesture = _getCirclePath(_offset, _radiusOut);
      if (offset != Offset(0, 0) && _pathGesture.contains(offset)) onSelect(i);
    }

    for (var i = 0; i < codes.length; i++) {
      var _start = _getOffetByIndex(codes[i]);
      if (i + 1 < codes.length) {
        var _end = _getOffetByIndex(codes[i + 1]);
        _drawLine(canvas, _start, _end);
      } else if (offset != Offset(0, 0)) {
        var _end = offset;
        _drawLine(canvas, _start, _end);
      }
    }
  }

  Path _getCirclePath(Offset offset, double radius) {
    var _rect = Rect.fromCircle(radius: radius, center: offset);
    return Path()
      ..addOval(_rect);
  }

  void _drawCircle(Canvas canvas, Offset offset, double radius, Color color,
      [bool isDot = false]) {
    var _path = _getCirclePath(offset, radius);
    var _painter = this._painter
      ..color = color
      ..style = isDot ? PaintingStyle.fill : PaintingStyle.stroke;
    canvas.drawPath(_path, _painter);
  }

  void _drawLine(Canvas canvas, Offset start, Offset end) {
    var _painter = this._painter
      ..color = Colors.grey.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    var _path = Path();
    _path.moveTo(start.dx, start.dy);
    _path.lineTo(end.dx, end.dy);
    canvas.drawPath(_path, _painter);
  }

  Color _getColorByIndex(int i) {
    return codes.contains(i) ? Colors.grey.shade700 : Colors.grey;
  }

  Offset _getOffetByIndex(int i) {
    var _dxCode = _sizeCode * (i % _col + .5);
    var _dyCode = _sizeCode * ((i / _col).floor() + .5);
    var _offsetCode = Offset(_dxCode, _dyCode);
    return _offsetCode;
  }

  @override
  bool shouldRepaint(_LockScreenPainter oldDelegate) {

    return offset != oldDelegate.offset;
  }
}