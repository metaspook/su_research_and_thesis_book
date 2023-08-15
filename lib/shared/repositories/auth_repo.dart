import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  const AuthRepo();

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, s) {
      log("Couldn't sign-up user", error: e, stackTrace: s);
    }
    return null;
  }
}
