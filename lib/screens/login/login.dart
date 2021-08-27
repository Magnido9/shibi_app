library authantication;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'homescreen.dart';
import 'mainscreen.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthRepository.instance(),
      child: MaterialApp(
        title: "APP",
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget{
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
    return Consumer<AuthRepository>(builder: (context, authrep, child) {
      return (authrep.status !=Status.Authenticated) ? HomeScreen(): MainScreen();
    });
  }
}
