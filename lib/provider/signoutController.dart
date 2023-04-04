import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOutController extends ChangeNotifier {
  Future signout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
