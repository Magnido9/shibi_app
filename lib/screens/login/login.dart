library authantication;
import 'package:application/data.dart';
import 'package:application/screens/login/caretakerid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'homescreen.dart';
import 'mainscreen.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Login extends StatelessWidget{
  @override
  // Widget build(BuildContext context) {
  //   final user = context.watch<User>();
  //
  //   if(user != null){
  //     return HomeScreen();
  //   }
  //   return MainScreen();
  // }
  Widget build(BuildContext context) {

      return MainScreen();
    }

}
