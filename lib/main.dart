import 'package:application/screens/login/password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login.dart';
import 'screens/login/homescreen.dart';
import 'screens/login/caretakerid.dart';
import 'services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'screens/Avatar/avatar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ///await AuthRepository.instance().signOut();
  // runApp(Wrapper());
  runApp(Wrapper());
  }



class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "app",
      home:  (AuthRepository.instance().isAuthenticated)? Password(first: false) :Login( )
    ) ;
  }
}

