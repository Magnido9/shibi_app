library data;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MyPage { instructions, caretakerid, login, avatar }

///and more
class CurrData extends ChangeNotifier {
  MyPage page = MyPage.login;
  User? user = null;

  void changePage(MyPage next) {
    page = next;
    notifyListeners();
  }
}
