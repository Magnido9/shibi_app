import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //AuthRepository.instance().signUp('alon.kitin3@gmail.com', '123456789');////////////////////////////////here
  runApp(Login());
}

class PageChooser extends StatelessWidget{
  @override
  Widget build(BuildContext c) {
    return Consumer<CurrData>(builder: (context, data, child) {
      Widget ret=Login();
      switch(data.page) {
        case MyPage.login: {
          ret=Login();
        }
        break;

        case MyPage.instructions: {
       //   ret=nstructions()
        }
        break;


      }
      return ret;
    });
  }
}

class PageChooserWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext c) {
    return ChangeNotifierProvider(
      create: (context) => CurrData(),
      child: PageChooser(),
    );
  }
}

