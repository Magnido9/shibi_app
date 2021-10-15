import 'package:application/screens/caretaker/home.dart';
import 'package:application/screens/checkin/checkin.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:application/screens/login/privacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login.dart';
import 'screens/login/caretakerid.dart';
import 'screens/home/home.dart';
import 'screens/Avatar/avatar.dart';
import 'services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/expo1/start.dart';
import 'screens/Avatar/avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Expo1(adata: AvatarData(),));
  // runApp(Wrapper());
}

class Wrapper extends StatefulWidget {
  @override
  _StateWrap createState() => _StateWrap();
}

class _StateWrap extends State<Wrapper> {
  bool isCare = false;
  @override
  void initState() {
    super.initState();
    _load();
  }

  //Loading counter value on start
  Future<bool> _load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isCare') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return (AuthRepository.instance().isAuthenticated)
        ? FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data?.getBool('isCare'));
                return (snapshot.data?.getBool('isCare') ?? true)
                    ? CareHome()
                    : Password(first: false);
              }
              return Center(child: CircularProgressIndicator());
            },
          )
        : Login();
  }
}
