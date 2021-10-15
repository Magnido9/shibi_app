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

class feeling1_1 extends StatefulWidget {
  feeling1_1();

  @override
  _feeling1_state createState() => _feeling1_state();
}

class _feeling1_state extends State<feeling1_1> {


  double pointer = 0;
  ScrollController _controller = ScrollController(initialScrollOffset: 0);
  @override
  @override

  Color _getColor() {
    double i = pointer;
    double blue_border = 20,
        green_border = 40,
        yellow_border = 60,
        pink_border = 80,
        red_border = 101,
        percent;
    if (i < blue_border) {
      percent = i / blue_border;
      return Color.alphaBlend(Color(0xffA3A2EE).withOpacity(1 - percent),
          Color(0xffA6D6C3).withOpacity(percent));
    }
    if (i < green_border) {
      percent = (i - blue_border) / (green_border - blue_border);
      return Color.alphaBlend(Color(0xffA6D6C3).withOpacity(1 - percent),
          Color(0xffF1B31C).withOpacity(percent));
    }
    if (i < yellow_border) {
      percent = (i - green_border) / (yellow_border - green_border);
      return Color.alphaBlend(Color(0xffF1B31C).withOpacity(1 - percent),
          Color(0xffEFB3E2).withOpacity(percent));
    }
    if (i < pink_border) {
      percent = (i - yellow_border) / (pink_border - yellow_border);
      return Color.alphaBlend(Color(0xffEFB3E2).withOpacity(1 - percent),
          Color(0xffFE615E).withOpacity(percent));
    } else {
      percent = (i - pink_border) / (red_border - pink_border);
      return Color.alphaBlend(Color(0xffFE615E).withOpacity(1 - percent),
          Color(0xffEC015E).withOpacity(percent));
    }
  }

  String _label() {
    double i = pointer;
    double blue_border = 20,
        green_border = 40,
        yellow_border = 60,
        pink_border = 80,
        red_border = 101,
        percent;
    if (i < blue_border) {
      return 'עצב';
    }
    if (i < green_border) {
      return 'גועל';
    }
    if (i < yellow_border) {
      return 'פחד';
    }
    if (i < pink_border) {
      return 'שמחה';
    } else {
      return 'כעס';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _getColor(),
            Colors.white,
          ],
        )),
        child: Stack(
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
                    color: Color(0xffF4F2F1),
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
                        child: Image.asset('images/expo/smile.png',
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
                      "זיהוי רגש",
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
                            "בואי נזהה יחד א ת הרגשות המוצפים.",
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
                            "בחרי את הרגשות שאת מרגישה כעת",
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
                Container(
                  height: 10,
                ),
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      height: height * 0.5,
                      width: width * 5.5,
                      // color: Colors.green,
                      child: Consumer<ExpoData>(
                        builder: (context, data, widget){
                          return Builder(builder: (context) {
                            height = height * 0.5;
                            double x = 50,
                                offset = 0,
                                radius = height * 0.125,
                                dis = radius * 0.1;
                            List<Widget> l = [];
                            List<Widget> m = [];
                            var f = (i, j) => _circle(
                                color: _getColor(),
                                text: data.feelings[i * 8 + j],
                                radius: radius,
                                isChosen: data.felt.contains(i * 8 + j),
                                onTap: () {
                                  if (data.felt.contains(i * 8 + j)) {
                                    setState(() {
                                      data.felt.remove(i * 8 + j);

                                    });

                                  } else {
                                    setState(() {
                                      data.felt.add(i * 8 + j);
                                    });

                                  }
                                });

                            // List<double>
                            for (int i = 0;
                            i < (data.feelings.length - data.feelings.length % 8) / 8;
                            i++) {
                              l.addAll([
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [f(i, 0)],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: x * 0),
                                      child: f(i, 1),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: x * 1),
                                        child: f(i, 2)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: x * 0),
                                        child: f(i, 3)),
                                    Container(
                                      margin: EdgeInsets.only(left: x * 1),
                                      child: f(i, 4),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: x * 2),
                                      child: f(i, 5),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: x * 0),
                                      child: f(i, 6),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: x * 1),
                                      child: f(i, 7),
                                    ),
                                  ],
                                ),
                              ]);
                            }
                            for (int i = 0; i < l.length; i++) {
                              m.add(Positioned(
                                child: l[i],
                                left: offset,
                                height: height,
                              ));
                              if (i % 4 == 0) offset += 2 * radius + dis - x / 2;
                              if (i % 4 == 1) offset += 2 * radius + dis - x / 2;
                              if (i % 4 == 2) offset += 2 * radius + dis + x;
                              if (i % 4 == 3) offset += 2 * radius + dis + x;
                            }
                            return Stack(
                              children: m,
                            );
                          });
                        },
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                    child: Slider(
                      activeColor: _getColor(),
                      thumbColor: Colors.grey,
                      value: pointer,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _label(),
                      onChanged: (double value) {
                        setState(() {
                          pointer = value;
                          _controller.jumpTo(value / 100 * width * 4.5);
                        });
                      },
                    )),
              ],
            ),
            if (Provider.of<ExpoData>(context, listen: false).felt.length >= 3)
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
                          Provider.of<ExpoData>(context, listen: false).done[1]=true;
                          Navigator.popUntil(
                              context, ModalRoute.withName('/main'));
                        },
                      ),
                      margin: EdgeInsets.all(8),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _circle extends StatelessWidget {
  _circle(
      {required this.color,
      this.text = "",
      required this.radius,
      this.onTap,
      this.isChosen = false});
  final double radius;
  final String text;
  final Color color;
  final isChosen;
  var onTap;
  @override
  Widget build(BuildContext context) {
    onTap = onTap ?? () {};
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(radius * 0.2),
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            border: (isChosen && text != '')
                ? Border.all(color: Colors.black, width: 1)
                : null,
            color: (text == '') ? null : color,
            shape: BoxShape.circle),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Assistant",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      onTap: (text == '') ? () {} : onTap,
    );
  }
}
