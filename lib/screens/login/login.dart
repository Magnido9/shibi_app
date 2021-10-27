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
import 'package:google_fonts/google_fonts.dart';

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
  bool isCare = false;

  void _checkIn(Future<UserCredential?> f, BuildContext context) async {
    UserCredential? u = await f;
    bool care = (await FirebaseFirestore.instance
            .collection('caretakers')
            .doc(u?.user?.uid)
            .get())
        .exists;
    //print( (u?.user?.uid)?? 'null ' +" - "+care.toString());

    (await SharedPreferences.getInstance()).setBool('isCare', care);

    if ((await f) != null)
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              care ? CareHome() : Password(first: false)));
  }

  void _checkUp(Future<UserCredential?> f, BuildContext context) async {
    (await SharedPreferences.getInstance()).setBool('isCare', isCare);

    if ((await f) != null) if (isCare)
      FirebaseFirestore.instance
          .collection("caretakers")
          .doc(AuthRepository.instance().user?.uid)
          .set({'uid': AuthRepository.instance().user?.uid},
              SetOptions(merge: true));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            isCare ? CareHome() : CareTakerId()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Stack(children: [
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
        Align(
            alignment: Alignment.topRight,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(height: 20),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(width: 20),
                        Image.asset("images/sheba.png"),
                        Container(width: 20),
                      ])
                ])),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png"),
            Text("הרשמה/התחברות לאפליקציה",
                style: GoogleFonts.assistant(
                    fontSize: 26, fontWeight: FontWeight.w700)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "מייל",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "סיסמא",
                ),
                obscureText: true,
              ),
            ),
            /*       onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = passwordController.text.trim();

                  _checkIn(AuthRepository.instance().signIn(
                        email,
                        password,context
                      ), context);



                },*/
            Container(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
                  Stack(children: [
                    Container(
                        width: 150,
                        height: 39,
                        child: MaterialButton(
                            onPressed: () {
                              final String email = emailController.text.trim();
                              final String password =
                                  passwordController.text.trim();

                              _checkIn(
                                  AuthRepository.instance()
                                      .signIn(email, password, context),
                                  context);
                            },
                            minWidth: 150,
                            height: 39,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36)),
                            color: Colors.greenAccent,
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 5,
                                right: 10,
                                child: Text(
                                  "התחברות",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Assistant",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ]))),
                    Positioned(
                        top: 5,
                        right: 115,
                        child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(color: Colors.white, width: 9),
                            ))),
                  ]),
              /* onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = passwordController.text.trim();
                      _checkUp(AuthRepository.instance().signUp(
                        email,
                        password,context
                      ),context);


                },*/Stack(children: [
                    Container(
                        width: 150,
                        height: 39,
                        child: MaterialButton(
                            onPressed: () {
                              final String email = emailController.text.trim();
                              final String password =
                                  passwordController.text.trim();
                              _checkUp(
                                  AuthRepository.instance()
                                      .signUp(email, password, context),
                                  context);
                            },
                            minWidth: 150,
                            height: 39,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36)),
                            color: Colors.redAccent,
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 5,
                                right: 20,
                                child: Text(
                                  "הרשמה",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Assistant",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ]))),
                    Positioned(
                        top: 5,
                        right: 115,
                        child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(color: Colors.white, width: 9),
                            ))),
                  ])
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ])
          ],
        ),
      ])),
    );
  }
}
