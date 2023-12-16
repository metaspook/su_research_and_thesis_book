import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

export 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, User, UserCredential;

class AuthRepo {
  //-- Config
  final _auth = FirebaseAuth.instance;
  final _errorMsgSignIn = "Couldn't sign-in the user!";
  final _errorMsgSignUp = "Couldn't sign-up the user!";
  final _errorMsgSignOut = "Couldn't sign-out the user!";
  final _errorMsgUpdateEmail = "Couldn't update the user email!";
  final _errorMsgUpdatePassword = "Couldn't update the user password!";

  //-- Public APIs
  Stream<User?> get userStream => _auth.userChanges().asBroadcastStream();
  User? get currentUser => _auth.currentUser;

  Future<String?> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      final errorMsg = const <String, String>{
        'invalid-email': 'Invalid email!',
        'email-already-in-use': "This email's user already exists!",
        'requires-recent-login':
            'Recent Sign-in required! Please sign out then in again.',
      }[e.code];
      return errorMsg;
    } catch (e, s) {
      log(_errorMsgUpdateEmail, error: e, stackTrace: s);
      return _errorMsgUpdateEmail;
    }
    return null;
  }

  Future<String?> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      final errorMsg = const <String, String>{
        'weak-password': "Password isn't strong enough!",
        'requires-recent-login':
            'Recent Sign-in required! Please sign out then in again.',
      }[e.code];
      return errorMsg;
    } catch (e, s) {
      log(_errorMsgUpdatePassword, error: e, stackTrace: s);
      return _errorMsgUpdatePassword;
    }
    return null;
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final errorMsg = const <String, String>{
        'weak-password': "Password isn't strong enough!",
        'requires-recent-login':
            'Recent Sign-in required! Please sign out then in again.',
      }[e.code];
      return errorMsg;
    } catch (e, s) {
      log(_errorMsgUpdatePassword, error: e, stackTrace: s);
      return _errorMsgUpdatePassword;
    }
    return null;
  }

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
      final errorMsg = const <String, String>{
        'invalid-email': 'Invalid email!',
        'user-disabled': "This email's user is disabled!",
        'user-not-found': "This email's user is not found!",
        'wrong-password': 'Invalid password or unassociated with email!',
      }[e.code];
      return errorMsg;
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

  Future<({String? errorMsg, String? userId})> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userId = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user
          ?.uid;

      return (errorMsg: null, userId: userId);
    } on FirebaseAuthException catch (e) {
      final errorMsg = const <String, String>{
        'email-already-in-use': "This email's user already exists!",
        'invalid-email': 'Invalid email!',
        'operation-not-allowed': "Email/password accounts aren't enabled!",
        'weak-password': "Password isn't strong enough!",
      }[e.code];
      return (errorMsg: errorMsg, userId: null);
    } catch (e, s) {
      log(_errorMsgSignUp, error: e, stackTrace: s);
      return (errorMsg: _errorMsgSignUp, userId: null);
    }
  }
}
