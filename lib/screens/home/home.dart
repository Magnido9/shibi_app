library home;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import '../../services/auth_services.dart';




class Home extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: null),
        body: const Center(
          child: Text('My Page!'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                  decoration: BoxDecoration(
                  color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                  FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection("users").doc(AuthRepository
                      .instance()
                      .user
                      ?.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            // ...
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data?.data() ??
                  {'name': " "};
              return Text('Hello ${data['name']}');
            }
            return CircularProgressIndicator();
          },
        ),
                      LoadAvatar(),
                    ],
                  )
                  ),
                  ListTile(
                  title: const Text("עצב דמות"),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Avatar()));
                    ///Navigator.push(context, MaterialPageRoute(builder: (context) => Avatar()));
                    ///Navigator.pop(context);
                  },
                  ),
                  ListTile(
                    title: const Text("התנתק"),
                    onTap: () {
                      Future<void> _signOut() async {
                        await FirebaseAuth.instance.signOut();
                      }
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                      ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                      ///Navigator.pop(context);
                      },
                  ),

                    ]
                  ),
                ),

            );

      }
}



