library authantication;
import 'package:application/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class _Connection extends ChangeNotifier{
  List<QueryDocumentSnapshot> list=[];



  void _getCare(int pass,BuildContext context) async{

    list= (await FirebaseFirestore.instance.collection("caretakers").where('usedId' ,isEqualTo: pass).get()).docs;
    //return q.docs[0].data()['uid'];
    if(list.isNotEmpty){
      _signToCare(list[0].data()['uid'], context);
    }
    notifyListeners();
  }
  void _signToCare(String carer, BuildContext context) async{
    String? pid = Provider.of<CurrData>(context, listen: false).user?.uid;
    if((await FirebaseFirestore.instance.collection("assigned").where('careid' ,isEqualTo: carer).where('patientid' ,isEqualTo: pid).get()).docs.isEmpty)
    await FirebaseFirestore.instance.collection("assigned").doc(carer).set({
      'careid': carer,
      'patientid': pid,

    });
    Provider.of<CurrData>(context, listen: false).page=MyPage.instructions;
  }
}


class CareTakerId extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CareTakerIdState();
  }
}



class _CareTakerIdState extends State<CareTakerId>{
  TextEditingController id = new TextEditingController();

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
                    decoration:  InputDecoration(labelText: "Enter your number"),
                    controller: id,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ],
              )),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.green,
            child:  TextButton(
              onPressed: () {
                final int pass =int.parse(id.text.trim()) ;
                _Connection()._getCare(pass, context);
                },
              child: Text("continue"),
            ),
          ),
        ],
      )

    );
  }
}

