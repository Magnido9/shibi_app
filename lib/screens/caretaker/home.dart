library home;
import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


class CareHome extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CareHome>{
  bool createPass=false;
  TextEditingController password = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('caretaker!'),
      ),
      drawer: Builder(builder: (context)=> Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('CareTaker'),
              ),
              ListTile(
                title: const Text("התנתק"),
                onTap: () {
                  Future<void> _signOut() async {
                    await FirebaseAuth.instance.signOut();
                  }
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext context) => Login()));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  ///Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("מפה!"),
                onTap: () {

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MapPage()));
                  ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                  ///Navigator.pop(context);
                },
              ),
              ListTile(
                selected: createPass,
                title: const Text("סיסמא"),
                onTap: () {
                      setState(() {
                        createPass= !createPass;
                      });
                },
              ),
              if(createPass) Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // Container(color: Colors.green, width: 10,height: 10,),
                  Container(width: MediaQuery.of(context).size.width*0.5,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ], //
                        controller: password,
                        decoration: InputDecoration(
                          hintText: "PASSWORD...",
                        ),
                      )
                  ),
                 Container(
                     height:  MediaQuery.of(context).size.width*0.2,
                     width:  MediaQuery.of(context).size.width*0.2,
                     child: TextButton(
                      onPressed: () {
                        final String pass = password.text.trim();
                        FirebaseFirestore.instance.collection("caretakers").doc(AuthRepository.instance().user?.uid).set({
                          'usedId' : pass
                        },SetOptions(merge: true));
                        setState(() {
                          createPass=!createPass;
                        });
                      },
                      child: Icon(Icons.view_in_ar),
                    )
                ),
                ],
              )

            ]
        ),
      ),

    )
    )
    );

  }
}



