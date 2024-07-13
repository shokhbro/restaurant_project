import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService with ChangeNotifier {
  Future<void> register(String email, String password) async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> login(String email, String password) async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> forgotPassword(String code, String newPassword) async {
    FirebaseAuth.instance.confirmPasswordReset(
      code: code,
      newPassword: newPassword,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }
}
