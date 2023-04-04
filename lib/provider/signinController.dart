import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignInController extends ChangeNotifier {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    Future signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
    notifyListeners();
  }
}