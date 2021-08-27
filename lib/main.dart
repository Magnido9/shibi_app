import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Page {instructions, caretakerid, login, avatar} ///and more
class CurrPage extends ChangeNotifier{
  Page page=Page.login;

  void changePage(Page next){
    page=next;
    notifyListeners();
  }

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //AuthRepository.instance().signUp('alon.kitin3@gmail.com', '123456789');////////////////////////////////here
  runApp(Login());
}

class PageChooser extends StatelessWidget{
  @override
  Widget build(BuildContext c) {
    return Consumer<CurrPage>(builder: (context, page, child) {
      Widget ret=Login();
      switch(page.page) {
        case Page.login: {
          ret=Login();
        }
        break;

        case Page.instructions: {
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
      create: (context) => CurrPage(),
      child: PageChooser(),
    );
  }
}

