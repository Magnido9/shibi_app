library home;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';



class Home extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.brown,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Avatar()));
                },
                child: Text("עצב דמות"),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.black,
              child: TextButton(
                onPressed: () {
                  Future<void> _signOut() async {
                    await FirebaseAuth.instance.signOut();
                                    }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                },
                child: Text("התנתק"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



