library expo;

import 'package:application/screens/Avatar/avatar.dart';
import 'package:application/screens/expo1/start.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import '../Avatar/color_switch.dart';
import 'dart:math';

class thought1_1 extends StatefulWidget {
  thought1_1();

  @override
  _thought1_state createState() => _thought1_state();
}

class _thought1_state extends State<thought1_1> {
  double feeling = 50;
  List<int> chosen = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -height,
              left: -width * 0.5,
              child: Container(
                width: width * 2,
                height: width * 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Color(0xffF3F1DE),
                ),
              )),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 50,
              child: Column(
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.grey.shade400,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset('images/expo/brain.png',
                          color: Color(0xffB3E8EF)),
                    ),
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff35258A),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.all(30),
            ),
          ),
          Column(
            children: [
              Container(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "זיהוי מחשבות",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Assistant",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      child: Center(
                        child: Text(
                          '?',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffc4c4c4),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Text('חכה שתראה את הטוסיק בחלק הגופני'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text(
                              'x',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.8,
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "בואי נזהה מחשבות מכשילות!",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Assistant",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          "בחרי ב-3 בלוני מחשבה אותם תרצי לאתגר.\n\nאתגור המחשבה יסיע להרגיע  את החרדה בכדי שתצליחי לבצע את החשיפה בהצלחה.",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Consumer<ExpoData>(
                  builder: (context, data, child) {

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        double w = constraints.maxWidth;
                        double h = constraints.maxHeight;
                        List<Offset> offsets = [
                          Offset(w * 0.06, h * 0.2),
                          Offset(w * 0.05, h * 0.61),
                          Offset(w * 0.4, h * 0.6),
                          Offset(w * 0.4, h * 0.1),
                          Offset(w * 0.75, h * 0.4),
                          Offset(w * 0.7, h * 0)
                        ];
                        List<double> diameters = [100, 120, 110, 140, 100, 110];
                        List<double> angles = [
                          0.1,
                          0.2,
                          -0.2,
                          -0.1,
                          -0.12,
                          0.1
                        ];
                        List<Widget> wlist = [];
                        for (int i = 0; i < min(6, data.thoughts.length); i++) {
                          wlist.add(Positioned(
                              top: offsets[i].dy,
                              left: offsets[i].dx,
                              child: GestureDetector(
                                child: Baloon(
                                  chosen: chosen.contains(i),
                                  id: i,
                                  angle: angles[i],
                                  diameter: diameters[i],
                                  text: data.thoughts[i],
                                  secondery: data.replies[i],
                                  color: i % 4,
                                ),
                                onTap: () async {
                                  if (chosen.contains(i))
                                    setState(() {
                                      chosen.remove(i);
                                    });
                                  else {
                                    var x = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => _BallonPage(
                                                color: i,
                                                text: data.thoughts[i],
                                                secondery: data.replies[i],
                                              )),
                                    );
                                    setState(() {
                                      data.replies[i] = x;
                                      chosen.insert(chosen.length, i);
                                    });
                                    print(chosen);
                                  }
                                },
                              )));
                        }
                        return Stack(
                          children: List.from(wlist)
                            ..addAll([
                              if (chosen.isNotEmpty)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      width: 64,
                                      height: 39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(36),
                                        color: Color(0xffb9b8b8),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 7,
                                        bottom: 8,
                                      ),
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Center(
                                        child: Text(
                                          chosen.length.toString() + "/3",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: "Assistant",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )),
                                ),
                              if (chosen.length == 3)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Color(0xff35258a),
                                            shape: CircleBorder(),
                                          ),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            // Provider.of<ExpoData>(context,
                                            //         listen: false)
                                            //     .replies = replies;
                                            Navigator.pushNamed(
                                                context, '/thoughts/2',
                                                arguments: chosen);

                                            // Navigator.pop(context,_controller?.text.trim());
                                          },
                                        ),
                                        margin: EdgeInsets.all(12),
                                      ),
                                    ],
                                  ),
                                )
                            ]),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class thought2_1 extends StatefulWidget {
  @override
  _thought2_state createState() => _thought2_state();
}

class _thought2_state extends State<thought2_1> {
  List<int> chosen = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    chosen = ModalRoute.of(context)!.settings.arguments as List<int>;
    print(width);
    return Scaffold(
      body: Stack(
        children: [
          TweenAnimationBuilder(
              tween: Tween(begin: height, end: - width*1.7),
              duration: Duration(seconds: 10),
              builder: (context,double h,w){
                Provider.of<ExpoData>(context, listen: false).done[2]=true;
                Future.delayed(const Duration(seconds: 10), (){ Navigator.popUntil(context,ModalRoute.withName('/main'));});
                return Positioned(
                    child: Builder(
                      builder: (context){
                        height = width * 1.7;
                        return Container(
                          width: width,
                          height: height,
                          child: Consumer<ExpoData>(builder: (context, data, child) {
                            AvatarData x= data.adata.clone();
                            x.hands = 'images/handsbaloon.png';
                            return Stack(
                              children: [
                                Positioned(
                                  child: Transform.rotate(
                                      angle: -0.8,
                                      child: Container(
                                        height: width * 0.2,
                                        width: 2,
                                        color: Colors.grey,

                                      )),
                                  top: height*0.565,
                                  left: width*0.37,),
                                Positioned(
                                  child: Transform.rotate(
                                      angle: 0.9,
                                      child: Container(
                                        height: width * 0.25,
                                        width: 2,
                                        color: Colors.grey,

                                      )),
                                  top: height*0.55,
                                  right: width*0.406,),
                                Positioned(
                                  child: Transform.rotate(
                                      angle: 0,
                                      child: Container(
                                        height: width * 0.27,
                                        width: 2,
                                        color: Colors.grey,

                                      )),
                                  top: height*0.5,
                                  left: width*0.46,),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    child: Transform.rotate(
                                        angle: -0.2 ,
                                        child: Container(
                                            height: width * 0.58,
                                            width: width * 0.6,
                                            child: AvatarStack(
                                              data: x,
                                            )
                                        )),
                                    margin: EdgeInsets.only(left: width*0.08),
                                  ),
                                ),
                                Positioned(
                                  child: Baloon(color:chosen[0], diameter: width*0.316, angle: -0.3, text: data.thoughts[chosen[0]],secondery: data.replies[chosen[0]],),
                                  top: height*0.4,
                                  left: width*0.1,),
                                Positioned(
                                  child: Baloon(color:chosen[1], diameter: width*0.316, angle: 0.3, text: data.thoughts[chosen[1]],secondery: data.replies[chosen[1]],),
                                  top: height*0.4,
                                  right: width*0.1,),
                                Positioned(
                                  child: Baloon(color:chosen[2], diameter: width*0.34, angle: 0, text: data.thoughts[chosen[2]],secondery: data.replies[chosen[2]],),
                                  top: height*0.3,
                                  left: width*0.3,),
                              ],
                            );
                          }),
                        );
                      },
                    ),
                    top: h
                );
              }
          ),

          Positioned(
              top: -height,
              left: -width * 0.5,
              child: Container(
                width: width * 2,
                height: width * 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Color(0xffF3F1DE),
                ),
              )),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 50,
              child: Column(
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.grey.shade400,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset('images/expo/brain.png',
                          color: Color(0xffB3E8EF)),
                    ),
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff35258A),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.all(30),
            ),
          ),
          Column(
            children: [
              Container(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "זיהוי מחשבות",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Assistant",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class _BallonPage extends StatefulWidget {
  _BallonPage(
      {required this.text, required this.color, required this.secondery});
  final int color;
  final String text;
  final String secondery;
  @override
  _ballonState createState() => _ballonState();
}

class _ballonState extends State<_BallonPage> {
  TextEditingController? _controller;
  double height = 0, width = 0;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.secondery);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (width == 0) width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff35258a),
                shape: CircleBorder(),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, _controller?.text.trim());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Stack(
              children: [
                Positioned(
                    bottom: height * 0.8,
                    right: width * 0.8,
                    child: Baloon(
                      id: 1,
                      angle: 0,
                      diameter: width * 0.5,
                      color: 1,
                      text: '',
                    )),
                Positioned(
                    bottom: height * 0.8,
                    left: width * 0.7,
                    child: Baloon(
                      id: 1,
                      angle: 0.1,
                      diameter: width * 0.6,
                      color: 3,
                      text: '',
                    )),
                Positioned(
                    top: height * 0.6,
                    left: width * 0.7,
                    child: Baloon(
                      id: 1,
                      angle: 0,
                      diameter: width * 0.8,
                      color: 2,
                      text: '',
                    )),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Baloon(
                        id: 1,
                        angle: 0,
                        diameter: width * 0.95,
                        color: widget.color,
                        text: '',
                      )),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.2),
                    width: width * 0.7,
                    height: width * 0.7,
                    child: Column(children: [
                      Text(
                        widget.text + "...",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff35258a),
                          fontSize: 26,
                          fontFamily: "Assistant",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: "Assistant",
                          fontWeight: FontWeight.w300,
                        ),
                        textDirection: TextDirection.rtl,
                        controller: _controller,
                        maxLines: 4,
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class Baloon extends StatelessWidget {
  Baloon({
    required this.color,
    required this.diameter,
    required this.angle,
    required this.text,
     this.id,
    this.secondery = '',
    this.chosen = false,
  });
  final bool chosen;
  final int? id;
  final String? secondery;
  final String text;
  final double diameter;
  final double angle;
  final int color;
  final colors = [
    Color(0xffDEEEF3),
    Color(0xffDEEEF3),
    Color(0xffCFC781).withOpacity(0.26),
    Color(0xff81CF8D).withOpacity(0.26),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      child: Stack(
        children: [
          if (chosen)
            Container(
              width: diameter,
              height: diameter * 0.95,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue)),
            ),
          Transform.rotate(
            angle: angle,
            child: ImageColorSwitcher(
              height: diameter,
              width: diameter,
              imagePath: 'images/expo/baloon.png',
              main: Color(0xff000000),
              second: Color(0xff95DEF4),
              color: colors[color % 4],
            ),
          ),
          Center(
            child: Container(
              width: 0.8 * diameter,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
//
                    TextSpan(
                      text: text.trim() + " ",
                      style: TextStyle(
                        color: Color(0xff35258a),
                        fontSize: 0.1 * diameter,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: secondery,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Assistant",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
