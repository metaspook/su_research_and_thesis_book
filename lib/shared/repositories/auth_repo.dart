import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:su_thesis_book/shared/models/models.dart' as models
    show AppUser;

models.AppUser? _user;
final _userController = StreamController<models.AppUser?>();

class AuthRepo {
  const AuthRepo();

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  // Public APIs
  // Stream<models.User?> get userStream => _userController.stream;
  Stream<User?> get userStream => _firebaseAuth.authStateChanges();
  void addUser(models.AppUser user) => _userController.add(user);
  void dispose() => _userController.close();
  // StreamController<models.User> get userController => _userController;

  void signOut() {
    _firebaseAuth.signOut();
    dispose();
  }

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

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, s) {
      log("Couldn't sign-in user", error: e, stackTrace: s);
    }
    return null;
  }
}
