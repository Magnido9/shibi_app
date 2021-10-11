library expo;

import 'package:application/screens/Avatar/avatar.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import '../Avatar/color_switch.dart';
import 'dart:math';

class thought1_1 extends StatefulWidget {
  thought1_1();
  final List<String> thoughts=[
    'אני תמיד אגיד או אעשה משהו',
    'הכי נורא שיכול לקרות זה',
    'תמיד כשאני עושה דברים כאלו',
    'אף אחד אף פעם לא אוהב ש',
    'אני מרגישה לא בנוח ולכן',
    'אני לא אדע איך'
  ];
  @override
  _thought1_state createState() => _thought1_state();
}

class _thought1_state extends State<thought1_1> {
  double feeling = 50;
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
                  Container(height: 10,),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset('images/expo/brain.png',color: Color(0xffB3E8EF)),),
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff35258A),
                    ),
                  )
                ],
              ) ,
              margin: EdgeInsets.all(30),
            ),
          ),
          Column(
            children: [
              Container(                height: 40,
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
                    width: width*0.8,
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
                child: LayoutBuilder(
                  builder: (context, constraints){
                    double w=constraints.maxWidth;
                    double h = constraints.maxHeight;
                    List<Offset> offsets=[
                      Offset(w*0.06,h*0.2),
                      Offset(w*0.05,h*0.65),
                      Offset(w*0.4,h*0.6),
                      Offset(w*0.4,h*0.1),
                      Offset(w*0.75,h*0.4),
                      Offset(w*0.7,h*0)
                    ];
                    List<double> diameters=[
                      100,120,110,140,100,110
                    ];
                    List<double> angles=[
                      0.1,0.2,-0.2,-0.1,-0.12,0.1
                    ];
                    List<Widget> wlist=[];
                    for (int i =0; i<min(6,widget.thoughts.length);i++){
                      wlist.add(Positioned(
                          top: offsets[i].dy,
                          left: offsets[i].dx,
                          child: GestureDetector(
                            child: Baloon(id:i,angle:angles[i],diameter: diameters[i],text:widget.thoughts[i],color: i%4,),
                            onTap: (){Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => _BallonPage()),
                            );},
                          )
                      )) ;
                    }
                    return Stack(children:
                      wlist,
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

class _BallonPage extends StatefulWidget{
  @override
  _ballonState createState() => _ballonState();
}

class _ballonState extends State<_BallonPage>{
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context){
    double width =MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return Scaffold(

      body: Stack(
        children: [
          Positioned(
              bottom:height*0.8,
              right: width*0.8,
              child: Baloon(
                id:1,
                angle:0,
                diameter:width*0.5,
                color:1,
                text:'',

              )),
          Positioned(
              bottom:height*0.8,
              left: width*0.7,
              child: Baloon(
                id:1,
                angle:0.1,
                diameter:width*0.6,
                color:3,
                text:'',

              )),
          Positioned(
              top:height*0.6,
              left: width*0.7,
              child: Baloon(
                id:1,
                angle:0,
                diameter:width*0.8,
                color:2,
                text:'',

              )),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top:height*0.1),
              child: Baloon(
                  id:1,
                  angle:0,
                  diameter:width*0.95,
                  color:1,
                  text:'',)
            ),
          )
        ],
      ),
    );
  }
}

class Baloon extends StatelessWidget{
  Baloon({
    required this.color,
    required this.diameter,
    required this.angle,
    required this.text,
    required this.id,
    this.secondery='',
    this.chosen=false,
  });
  final bool chosen;
  final int id;
  final String? secondery;
  final String text;
  final double diameter;
  final double angle;
  final int color;
  final colors=[Color(0xffDEEEF3),Color(0xffDEEEF3),Color(0xffCFC781).withOpacity(0.26),Color(0xff81CF8D).withOpacity(0.26),];


  @override
  Widget build(BuildContext context){
    return Container(height: diameter, width: diameter,
      child: Stack(
      children: [
        if(chosen) Container(
          width: diameter,
          height: diameter*0.95,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue)
          ),
        ),
        Transform.rotate(
          angle: angle,
          child: ImageColorSwitcher(height: diameter, width: diameter, imagePath: 'images/expo/baloon.png', main: Color(0xff000000),second: Color(0xff95DEF4),color: colors[color%4],),

        ),
        Center(
          child: Container(
            width: 0.8*diameter,
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
                      text: text,
                    style: TextStyle(
                    color: Color(0xff35258a),
                    fontSize: 0.1*diameter,
                    fontFamily: "Assistant",
                    fontWeight: FontWeight.w700,
                  ),),
                  TextSpan(
                      text: secondery,
                      style:TextStyle(
                        fontSize: 14,
                        fontFamily: "Assistant",
                      ),),
                ],
              ),
            ),
          ),
        ),
      ],
    ),);
  }
}

