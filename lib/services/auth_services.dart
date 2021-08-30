library auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
String error_message="";
/*class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } catch(e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
          'uid': user?.uid,
          'email': email,
          'password': password,
        });
      });
      return "Signed Up";
    } catch(e) {
      print(e);
      return e.toString();
    }
  }
} */

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthRepository with ChangeNotifier {
  FirebaseAuth _auth;
  User? _user;
  Status _status = Status.Uninitialized;

  AuthRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
    _user = _auth.currentUser;
    _onAuthStateChanged(_user);
  }

  Status get status => _status;

  User? get user => _user;

  bool get isAuthenticated => status == Status.Authenticated;

  Future<UserCredential?> signUp(String email, String password,BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text("You must use a proper email, and password must be 6 or longer"),

      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
      error_message=e.toString();
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<UserCredential?> signIn(String email, String password,BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text('Wrong Password/Username'),

      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
      error_message=e.toString();
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
