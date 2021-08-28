import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login.dart';
import 'screens/login/homescreen.dart';
import 'screens/login/caretakerid.dart';
import 'services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //AuthRepository.instance().signUp('alon.kitin3@gmail.com', '123456789');////////////////////////////////here
  runApp(PageChooserWrapper());
}

class PageChooser extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

      return Login();
  }
}

class PageChooserWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthRepository.instance(),
      child: MaterialApp(
        title: "APP",
        home: PageChooser(),
      ),
    );
  }
}

