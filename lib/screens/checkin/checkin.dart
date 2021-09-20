library feelings;
import 'dart:math';

import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import '../../services/auth_services.dart';


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

class FeelingPage extends StatefulWidget{
  @override
  _FeelingState createState() => _FeelingState();
}

class _FeelingState extends State<FeelingPage>{
  double feeling=0;
  Offset offset=Offset(0,0);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _sizePainter = Size.square(_width*0.7);
    return Scaffold(
      appBar: AppBar(
          title: Text('איך אתה מרגיש יא חתיכת חותך וורידים')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(4),

            child: GestureDetector(
              child: CustomPaint(
                painter: _FeelingPainter(
                   offset: offset),
                size: _sizePainter,
              ),
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
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

class _FeelingPainter extends CustomPainter{

  final Offset offset;

  _FeelingPainter({
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {

    var painter = Paint()
      ..style = PaintingStyle.stroke
      ..color =Color.alphaBlend(Colors.blue, Colors.green)
      ..strokeWidth = 4;
    Offset center= Offset(size.width/2, size.height/2);
    canvas.drawCircle(center, size.width/2, painter);
  }

  @override
  bool shouldRepaint(_FeelingPainter oldDelegate) {

    return offset != oldDelegate.offset;
  }
}