library authantication;

import 'package:application/screens/Avatar/avatar.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Privacy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PrivacyState();
  }
}

class _PrivacyState extends State<Privacy> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.deepPurpleAccent;
    }
    return Colors.deepPurpleAccent;
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
          left: -((0.8125 * MediaQuery.of(context).size.height) -
                  MediaQuery.of(context).size.width) /
              2,
          top: -0.1 * MediaQuery.of(context).size.height,
          child: Container(
              width: 0.8125 * MediaQuery.of(context).size.height,
              height: 0.8125 * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                    0x42cfc780,
                  )))),
      Positioned(
          right: 32,
          top: 97,
          child: Align(
              alignment: Alignment.topRight,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "פרטיות באפליקציה",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),

                      //,"לכן, האפליקציה לא מאפשרת מענה חירום. n\את מה שאת מעלה בזמן אמת - n\אבל, המטפל/ת שלך לא תמיד רואה n\n\n\n\n\המועלה לאפליקציה. n\רק למטפל/ת שלך יש גישה למידע "
                    ),
                    Container(
                      height: 20,
                    ),
                    Text(
                      "רק למטפל\\ת שלך יש גישה למידע\nהמועלה באפליקציה",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(
                      "כולל יומן מחשבות ורגשות, ",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Color(0xff6f6ca7),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "דפי עבודה וניתור תגובותיך לכל תרגיל.",
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.assistant(
                        color: Color(0xff6f6ca7),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      width: 313,
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0x2d34248a),
                          width: 1,
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(
                      "אבל המטפל\\ת שלך לא תמיד רואה\nאת מה שאת מעלה בזמן אמת -\nלכן, האפליקציה לא מאפשרת מענה חירום.",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]))),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          right: MediaQuery.of(context).size.width / 2 - 100,
          child: Row(children: <Widget>[
            Checkbox(
              checkColor: Color(0xff6f6ca7),
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text(
              "אני מאשרת שקראתי",
              textAlign: TextAlign.right,
              style: GoogleFonts.assistant(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ])),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.6,
          right: MediaQuery.of(context).size.width / 2 - 100,
          child: Stack(children: [
            Container(
                width: 200,
                height: 39,
                child: MaterialButton(
                    onPressed: () {
                      if (isChecked)
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Password(first: true)));
                      else {
                        final snackBar = SnackBar(
                          content:
                              const Text('יש לאשר את הסכם הפרטיות בכדי להמשיך'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        right: 50,
                        child: Text(
                          "מעולה!",
                          textDirection: TextDirection.rtl,
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
                right: 165,
                child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(color: Colors.white, width: 9),
                    ))),
          ]))
    ]));
  }
}
