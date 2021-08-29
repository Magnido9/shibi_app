library authantication;
import 'package:application/screens/login/caretakerid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_services.dart';
import '../home/home.dart';
import 'password.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.isInit}) : super(key: key);
  final bool isInit;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.isInit)
      Navigator.push(context, MaterialPageRoute(builder: (context) => Password(first:false)));
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

                  if(email.isEmpty){
                    print("Email is Empty");
                  } else {
                    if(password.isEmpty){
                      print("Password is Empty");
                    } else {
                      _checkIn(AuthRepository.instance().signIn(
                        email,
                        password,
                      ), context);

                    }
                  }
                },
                child: Text("LOG IN"),
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

                  if(email.isEmpty){
                    print("Email is Empty");
                  } else {
                    if(password.isEmpty){
                      print("Password is Empty");
                    } else {
                      _checkUp(AuthRepository.instance().signUp(
                        email,
                        password,
                      ),context);
                    }
                  }
                },
                child: Text("SIGN UP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _checkIn(Future<UserCredential?> f, BuildContext context) async{
  if ((await f)!= null) Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Password(first: false)),
  );
}
void _checkUp(Future<UserCredential?> f, BuildContext context) async{
  if ((await f)!= null) Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CareTakerId()),
  );
}