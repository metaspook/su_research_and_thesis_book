import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

export 'package:firebase_auth/firebase_auth.dart' show User;

const _errorMsgSignIn = "Couldn't sign-in the user!";
const _errorMsgSignUp = "Couldn't sign-up the user!";
const _errorMsgSignOut = "Couldn't sign-out the user!";

class AuthRepo {
  const AuthRepo();

  FirebaseAuth get _auth => FirebaseAuth.instance;

  //-- Public APIs
  Stream<User?> get userStream => _auth.authStateChanges();

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return const <String, String>{
        'invalid-email': 'Invalid email!',
        'user-disabled': "This email's user is disabled!",
        'user-not-found': "This email's user is not found!",
        'wrong-password': 'Invalid password or unassociated with email!',
      }[e.code];
    } catch (e, s) {
      log(_errorMsgSignIn, error: e, stackTrace: s);
      return _errorMsgSignIn;
    }
    return null;
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, s) {
      log(_errorMsgSignOut, error: e, stackTrace: s);
      return _errorMsgSignOut;
    }
    return null;
  }

  Future<(String?, {User? user})> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return (null, user: user);
    } on FirebaseAuthException catch (e) {
      final errorMsg = const <String, String>{
        'email-already-in-use': "This email's user already exists!",
        'invalid-email': 'Invalid email!',
        'operation-not-allowed': "Email/password accounts aren't enabled!",
        'weak-password': "Password isn't strong enough!",
      }[e.code];
      return (errorMsg, user: null);
    } catch (e, s) {
      log(_errorMsgSignUp, error: e, stackTrace: s);
      return (_errorMsgSignUp, user: null);
    }
  }
}
