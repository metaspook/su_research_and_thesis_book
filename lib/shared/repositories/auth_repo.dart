import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:su_thesis_book/shared/models/models.dart' as models;

models.User? _user;
final _userController = StreamController<models.User>();

class AuthRepo {
  const AuthRepo();

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  // Public APIs
  Stream<models.User?> get userStream => _userController.stream;
  void addUser(models.User user) => _userController.add(user);
  void dispose() => _userController.close();
  // StreamController<models.User> get userController => _userController;

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
