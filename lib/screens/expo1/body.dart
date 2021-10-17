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

class body1_1 extends StatefulWidget {

  @override
  _body1_state createState() => _body1_state();
}

class _body1_state extends State<body1_1> {
  bool isBack= false;
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
                  color: Color(0xffDEF3DF),
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
                      child: Image.asset('images/expo/meditate.png',
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
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: FlatButton(
                color: Colors.transparent,
                onPressed: () {},
                child: new IconTheme(
                  data: new IconThemeData(size: 35, color: Color(0xff6f6ca7)),
                  child: new Icon(Icons.menu),
                ),
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
                    "הרפיית הגוף",
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
                        content: Text('הנה הטוסיק שהבטחתי לך'),
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
                          "היכן את מרגישה כאב?",
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
                          "סובבי את שיבי וסמני את המקומות בהם את מרגישה כאב.",
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
                    AvatarData x = data.adata.clone();
                    x.hands = 'images/handsdown.png';
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        double w = constraints.maxWidth;
                        double h = constraints.maxHeight;
                        print(h);
                        print(w);
                        double dx = min(w,h), radius = dx*0.02;
                        var f = (str)=> _circle(isSelected: (data.painSpots.contains(str)),width: radius*2,onTap: (){ setState(() {data.painSpots.add(str);}); }, );
                        List<Widget> widgets = [
                          Positioned( top:dx*0.4 , left: dx*0.5-radius, child: f('בטן')),
                          Positioned( top:dx*0.24 , left: dx*0.5-radius, child: f('סנטר')),
                          Positioned( top:dx*0.1 , left: dx*0.5-radius, child: f('ראש')),
                          Positioned( top:dx*0.29 , left: dx*0.38-radius, child: f('חזה')),
                          Positioned( top:dx*0.29 , left: dx*0.62-radius, child: f('לב')),
                          Positioned( top:dx*0.31 , left: dx*0.7-radius, child: f('כתף')),
                          Positioned( top:dx*0.31 , left: dx*0.3-radius, child: f('כתף')),
                          Positioned( top:dx*0.38 , left: dx*0.28-radius, child: f('יד')),
                          Positioned( top:dx*0.38 , left: dx*0.72-radius, child: f('יד')),
                          Positioned( top:dx*0.6 , left: dx*0.43-radius, child: f('רגל')),
                          Positioned( top:dx*0.6 , left: dx*0.57-radius, child: f('רגל')),







                        ];
                        return Container(
                          width: dx,
                          height: dx,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  child: Container(
                                    height: w*0.3,
                                    width: w,
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Image.asset('images/platform.png'),
                                    ),
                                  ),
                                  onTap: (){
                                    return setState(() {
                                      isBack = !isBack;
                                    });
                                  },
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    margin: EdgeInsets.only(bottom:dx*0.2),
                                    child:  AvatarStack(data: x),
                                  )
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: w*0.2,
                                  child: ListView.builder(
                                    itemCount: data.painSpots.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return GestureDetector(
                                        onTap: (){setState(() {
                                          data.painSpots.remove(data.painSpots[index]);
                                        });},
                                        child:  Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                              Icon(Icons.remove, color:Color(0xff35258a)),
                                              Text(
                                                data.painSpots[index],
                                                textDirection: TextDirection.rtl  ,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),)],),
                                            height: 31,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffebebeb),
                                            )),
                                      );
                                    },
                                  ),
                                )
                              )
                            ]..addAll(widgets),

                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
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
                      Provider.of<ExpoData>(context, listen: false).done[0]=true;
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
    );
  }
}

class _circle extends StatelessWidget{
  _circle({required this.width,required this.isSelected,required this.onTap, });
  double width;
  bool isSelected;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(isSelected)? (){} : onTap,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            border: Border.all(
                color: Color(0xff35258A)
            ),
            shape: BoxShape.circle,
            color: (isSelected)? Color(0xffEDE74C) : Color(0xffC4C4C4)
        ),
      ),
    );
  }
}
