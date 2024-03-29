library authantication;

import 'package:application/screens/Avatar/avatar.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Money extends StatelessWidget {
  Money({required this.to_give, required this.first});
  bool first;
  int to_give=0;

  Future<void> _add() async {

    String? pid = AuthRepository.instance().user?.uid;
    var v =
    (await FirebaseFirestore.instance.collection("avatars").doc(pid).get());
    int money=0;
    if(v.data()==null){
      money=0;}
   else {
      money = v['money'];
    }
   print(money);
    money+=this.to_give;
     await FirebaseFirestore.instance
          .collection("avatars")
          .doc(pid)
          .set({'money':money}, SetOptions(merge: true));
    }
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
    return MaterialApp(
        home: Builder(
          builder: (context){
            return Scaffold(
                body:  Stack(children: [
                  Positioned(
                      left: -0.8*MediaQuery.of(context).size.width ,
                      top: -1.25* MediaQuery.of(context).size.height,
                      child: Container(
                          width: 0.8125 * MediaQuery.of(context).size.height*2,
                          height: 0.8125 * MediaQuery.of(context).size.height*1.8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(
                                0x2beb7a99,
                              )))),              Positioned(
                      right: 25,
                      top: 75,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "עיצוב השיבי שלך",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.assistant(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ]))),

                  // Figma Flutter Generator Group304Widget - GROUP

                  Positioned(
                      left: 22,
                      top: 131.32,
                      child: build_money("0")),
                  Positioned(
                      right:  MediaQuery.of(context).size.width*0.08,
                      top:  MediaQuery.of(context).size.height*0.19,child:Stack(children: [ Container(
                    width: 192,
                    height: 29,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(88),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Color(0xffc4c4c4),
                    ),

                  ),
                    Container(
                      width: 96,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(88),
                        color: Color(0xff35258a),
                      ),
                    ),
                    Positioned(  child:Text('חנות',style:GoogleFonts.assistant(color:Colors.white,fontWeight: FontWeight.w700)),left:30,top:6),

                    Positioned(  child:Text('המוצרים שלי',style:GoogleFonts.assistant(color:Colors.white,fontWeight: FontWeight.w700)),left:105,top:6)
                  ],)),
                  Positioned(
                    left: 45,
                    top: 120,
                    child: IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                  left: 20,
                  bottom: 30,
                  child:  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff35258a),
                      shape: CircleBorder(),
                      fixedSize: Size(55, 55),
                    ),
                    child: Icon(
                      Icons.arrow_back ,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _add();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Avatar(first:this.first)));
                    },
                  ),
                ),

                  Positioned(
                  top: 0.25* MediaQuery.of(context).size.height,
                      bottom:0.2* MediaQuery.of(context).size.height,
                      right: 0.1* MediaQuery.of(context).size.width,
                      left:  0.1* MediaQuery.of(context).size.width,
                      child:Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Color(0xff35258a), width: 2, ),
                            color: Color(0xfff4f4f4),
                          ),

                    child:Stack(children: [
                      Align(
                      alignment: FractionalOffset.bottomRight,
                      child: Container(
                        child: FittedBox(
                          child: Image.asset('images/shibi_pages/money.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ), Positioned(
                        bottom: 0.5*0.65* MediaQuery.of(context).size.height,
                        left: 0,
                        right:0,
                        top:0,
                        child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children:[  Text(
                        "יאייייי!",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.assistant(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),),Text(
                        " זכית ב-"+this.to_give.toString()+" מטבעות",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.assistant(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),),Text(
                        "השתמשו בהם בחוכמה ;]",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.assistant(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),)



                ]))],)))
            ])


                );
          },
        )
    );
  }

  Widget build_money(String text) {
    return Stack(children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.white,
        ),
      ),
      Container(
        width: 24,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.white,
        ),
      ),
      Container(
        width: 24,
        height: 26,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 0.65,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ]);
  }


}
