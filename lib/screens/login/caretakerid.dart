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

  @override
  Widget build(BuildContext context){
    return  Scaffold(
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

    );
  }
}

