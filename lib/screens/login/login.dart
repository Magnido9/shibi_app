library authantication;
import 'package:application/screens/caretaker/home.dart';
import 'package:application/screens/login/caretakerid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_services.dart';
import '../home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isCare =false;

  void _checkIn(Future<UserCredential?> f, BuildContext context) async{
    UserCredential? u=await f;
    bool care= (await FirebaseFirestore.instance.collection('caretakers').doc(u?.user?.uid).get()).exists;
    //print( (u?.user?.uid)?? 'null ' +" - "+care.toString());

    (await SharedPreferences.getInstance()).setBool('isCare', care);

    if ((await f)!= null)
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>care ? CareHome() :Password(first: false))
      );
  }

  void _checkUp(Future<UserCredential?> f, BuildContext context) async{
    (await SharedPreferences.getInstance()).setBool('isCare', isCare);

    if ((await f)!= null)
      if(isCare) FirebaseFirestore.instance.collection("caretakers").doc(AuthRepository.instance().user?.uid).set({
        'uid': AuthRepository.instance().user?.uid
      },SetOptions(merge: true));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => isCare ? CareHome() :CareTakerId()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN / SIGN UP"),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50,),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "EMAIL...",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50,),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "PASSWORD...",
                ),
                obscureText: true,
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.green,
              child: TextButton(
                onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = passwordController.text.trim();

                  _checkIn(AuthRepository.instance().signIn(
                        email,
                        password,context
                      ), context);



                },
                child: Text("כניסה"),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.red,
              child: TextButton(
                onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = passwordController.text.trim();
                      _checkUp(AuthRepository.instance().signUp(
                        email,
                        password,context
                      ),context);


                },
                child: Text("הרשמה"),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text('מטפל?'),
                Switch(
                  value: isCare,
                  onChanged: (value) {
                      setState(() {
                        isCare = value;
                      print(isCare);
                      });
                    },
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}

