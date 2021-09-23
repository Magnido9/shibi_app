library authantication;
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


class _Connection extends ChangeNotifier{
  List<QueryDocumentSnapshot> list=[];



  void _getCare(int pass,String name,BuildContext context) async{

    list= (await FirebaseFirestore.instance.collection("caretakers").where('usedId' ,isEqualTo: pass).get()).docs;
    //return q.docs[0].data()['uid'];
    if(list.isNotEmpty){
      _signToCare(list[0].data()['uid'],name, context);
    }
    notifyListeners();
  }
  void _signToCare(String carer,String name, BuildContext context) async {
    String? pid = AuthRepository
        .instance()
        .user
        ?.uid;
    if ((await FirebaseFirestore.instance.collection("users").where(
        'uid', isEqualTo: pid).get()).docs.isEmpty) {
      await FirebaseFirestore.instance.collection("users").doc(pid).set({
        'caretakeId': carer,
        'name': name,
        'uid': pid
      });

    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => Password(first: true)));
  }
}

class CareTakerId extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CareTakerIdState();
  }
}



class _CareTakerIdState extends State<CareTakerId>{
  TextEditingController pid = new TextEditingController();
  TextEditingController name = new TextEditingController();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  int code=0;

  @override
  void initState() {
    super.initState();
    code=0;
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
  Widget build(BuildContext context){
    return  /*Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        children: [
          Container(
              padding: const EdgeInsets.all(40.0),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration:  InputDecoration(labelText: "הכנס את הקוד שקיבלת מהמטפל"),
                    controller: pid,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(40.0),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration:  InputDecoration(labelText: "הכנס את שמך"),
                    controller: name,
                  ),
                ],
              )),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.green,
            child:  TextButton(
              onPressed: () {
                final int pass =int.parse(pid.text.trim()) ;
                _Connection()._getCare(pass,name.text.trim(), context);
                },
              child: Text("המשך"),
            ),
          ),
        ],
      )

    )*/
        Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
              alignment: Alignment.centerRight,
              child:
              Text(
              "היי",
              //textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w700,
              ),
            ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
              Text(
                "?לפני שנתחיל, מה הקוד שקיבלת מהמטפל שלך",
                //textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "Assistant",
                  fontWeight: FontWeight.w700,
                ),
              ),

              ),

              SizedBox(height:  MediaQuery.of(context).size.height * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 57,
                      height: 108,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff8ec3aa), width: 4, ),
                      ),
    child: SizedBox(
                    width: 60,
                    child: TextFormField(
                      autofocus: true,
                      obscureText: true,
                      style: TextStyle(color: Color(0xff6f6f6f),
                        fontSize: 36,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,

                      onChanged: (value) {
                        code=code*10+(int.parse(value));
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  )),
    Container(
    width: 57,
    height: 108,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Color(0xff8ec3aa), width: 4, ),
    ),
    child: SizedBox(
                    width: 60,
                    child: TextFormField(
                      focusNode: pin2FocusNode,
                      obscureText: true,
                      style: TextStyle(color: Color(0xff6f6f6f),
                        fontSize: 36,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        code=code*10+(int.parse(value));
                        nextField(value, pin3FocusNode);
                        },
                    ),
                  )),
                  Container(
                      width: 57,
                      height: 108,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff8ec3aa), width: 4, ),
                      ),
                      child: SizedBox(
                    width: (60),
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      obscureText: true,
                      style: TextStyle(
                        color: Color(0xff6f6f6f),
                        fontSize: 36,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        code=code*10+(int.parse(value));
                        nextField(value, pin4FocusNode);},
                    ),
                  )),
    Container(
    width: 57,
    height: 108,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Color(0xff8ec3aa), width: 4, ),
    ),
    child: SizedBox(
                    width: (60),
                    child: TextFormField(
                      focusNode: pin4FocusNode,
                      obscureText: true,
                      style: TextStyle(color: Color(0xff6f6f6f),
                        fontSize: 36,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
    code=code*10+(int.parse(value)); nextField(value, pin5FocusNode);},
                    ),
                  )),

    Container(
    width: 57,
    height: 108,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Color(0xff8ec3aa), width: 4, ),
    ),
    child: SizedBox(
                    width: (60),
                    child: TextFormField(
                      focusNode: pin5FocusNode,
                      obscureText: true,
                      style: TextStyle(color: Color(0xff6f6f6f),
                        fontSize: 36,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value.length == 1) {
                          code=code*10+  (int.parse(value));
                          print(code);

                          pin5FocusNode!.unfocus();
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  )),
                ],
              ),
              SizedBox(height:  MediaQuery.of(context).size.height * 0.1),
              MaterialButton(

                color: Color(0xFF1A237E),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(36) ),
                onPressed:  (){  _Connection()._getCare(code,name.text.trim(), context);},


                  child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:  Text(
                    '               שלח               ',
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Assistant",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
  }
}

