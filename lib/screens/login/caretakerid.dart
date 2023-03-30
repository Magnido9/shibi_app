library authantication;

import 'dart:math';

import 'package:application/screens/home/home.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:application/screens/login/privacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class _Connection extends ChangeNotifier {
  List<QueryDocumentSnapshot> list = [];

  Future<bool> _getCare(int pass, String name, BuildContext context) async {
    bool ret = false;
    list = (await FirebaseFirestore.instance
            .collection("caretakers")
            .where('usedId', isEqualTo: pass.toString())
            .get())
        .docs;
    //return q.docs[0].data()['uid'];
    if (list.isNotEmpty) {
      _signToCare((list[0].data()! as Map)['uid'], name, context);
    } else
      ret = true;
    notifyListeners();
    return ret;
  }

  void _signToCare(String carer, String name, BuildContext context) async {
    String? pid = AuthRepository.instance().user?.uid;
    if ((await FirebaseFirestore.instance
            .collection("users")
            .where('uid', isEqualTo: pid)
            .get())
        .docs
        .isEmpty) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(pid)
          .set({'caretakeId': carer, 'name': name, 'uid': pid});
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }
}

class CareTakerId extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CareTakerIdState();
  }
}

class _CareTakerIdState extends State<CareTakerId> {
  TextEditingController pid = new TextEditingController();
  TextEditingController name = new TextEditingController();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  var code = List.filled(5, 0);

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                CustomPaint(
                  painter: _Painter(),
                  size: MediaQuery.of(context).size,
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: 100,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "היי",
                            //textAlign: TextAlign.right,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "?לפני שנתחיל, מה הקוד שקיבלת מהמטפל שלך",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 4,
                                child: Container(
                                    width: 57,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff8ec3aa),
                                        width: 4,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        autofocus: true,
                                        obscureText: true,
                                        style: GoogleFonts.assistant(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          code[0] = int.parse(value);
                                          nextField(value, pin2FocusNode);
                                        },
                                      ),
                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                )),
                            Flexible(
                                flex: 4,
                                child: Container(
                                    width: 57,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff8ec3aa),
                                        width: 4,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        focusNode: pin2FocusNode,
                                        obscureText: true,
                                        style: GoogleFonts.assistant(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          code[1] = int.parse(value);
                                          nextField(value, pin3FocusNode);
                                        },
                                      ),
                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                )),
                            Flexible(
                                flex: 4,
                                child: Container(
                                    width: 57,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff8ec3aa),
                                        width: 4,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: (60),
                                      child: TextFormField(
                                        focusNode: pin3FocusNode,
                                        obscureText: true,
                                        style: GoogleFonts.assistant(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        /*style: TextStyle(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontFamily: "Assistant",
                                          fontWeight: FontWeight.w700,
                                        ),*/
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          code[2] = int.parse(value);
                                          nextField(value, pin4FocusNode);
                                        },
                                      ),
                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                )),
                            Flexible(
                                flex: 4,
                                child: Container(
                                    width: 57,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff8ec3aa),
                                        width: 4,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: (60),
                                      child: TextFormField(
                                        focusNode: pin4FocusNode,
                                        obscureText: true,
                                        /*style: TextStyle(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontFamily: "Assistant",
                                          fontWeight: FontWeight.w700,
                                        ),*/
                                        style: GoogleFonts.assistant(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          code[3] = int.parse(value);

                                          nextField(value, pin5FocusNode);
                                        },
                                      ),
                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                )),
                            Flexible(
                                flex: 4,
                                child: Container(
                                    width: 57,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff8ec3aa),
                                        width: 4,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: (60),
                                      child: TextFormField(
                                        focusNode: pin5FocusNode,
                                        obscureText: true,
                                        /*style: TextStyle(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontFamily: "Assistant",
                                          fontWeight: FontWeight.w700,
                                        ),*/
                                        style: GoogleFonts.assistant(
                                          color: Color(0xff6f6f6f),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          if (value.length == 1) {
                                            code[4] = int.parse(value);
                                            print(code);

                                            pin5FocusNode!.unfocus();
                                            // Then you need to check is the code is correct or not
                                          }
                                        },
                                      ),
                                    ))),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        Stack(children: [
                          Container(
                              width: 200,
                              height: 39,
                              child: MaterialButton(
                                  onPressed: () async {
                                    print(code.toString());
                                    int c = 0;
                                    for (int i = 0; i < code.length; i++)
                                      c = c * 10 + code[i];
                                    print(c);
                                    var b = await _Connection()
                                        ._getCare(c, name.text.trim(), context);
                                    print(b);
                                    if (b) {
                                      final snackBar = SnackBar(
                                        content: const Text('Wrong Password'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  minWidth: 200,
                                  height: 39,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(36)),
                                  color: Color(0xff35258a),
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                      top: 5,
                                      right: 60,
                                      child: Text(
                                        "שלח",
                                        textDirection: ui.TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.assistant(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  ]))),
                          Positioned(
                              top: 5,
                              right: 166,
                              child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    border: Border.all(
                                        color: Colors.white, width: 9),
                                  ))),
                        ])
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width * 0.3, size.width * 0.7);
    double radius = size.width * 0.8;
    var painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xff6F6CA7).withOpacity(0.14);
    canvas.drawCircle(center, radius, painter);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return false;
  }
}
