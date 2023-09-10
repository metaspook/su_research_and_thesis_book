import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

export 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, User, UserCredential;

class AuthRepo {
  AuthRepo() : _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth;

  //-- Config
  static const _errorMsgSignIn = "Couldn't sign-in the user!";
  static const _errorMsgSignUp = "Couldn't sign-up the user!";
  static const _errorMsgSignOut = "Couldn't sign-out the user!";
  static const _errorMsgUpdateEmail = "Couldn't update the user email!";
  static const _errorMsgUpdatePassword = "Couldn't update the user password!";
  static UserCredential? _userCredential;

  //-- Public APIs
  Stream<User?> get userStream => _auth.userChanges();
  User? get currentUser => _auth.currentUser;
  UserCredential? get userCredential => _userCredential;

//   Future<void> _reauthenticateAndDelete() async {
//     try {
//       final providerData = _auth.currentUser?.providerData.first;
//       final providerData = _auth.currentUser?.reload();

//       if (AppleAuthProvider().providerId == providerData!.providerId) {
//         await _auth.currentUser!
//             .reauthenticateWithProvider(AppleAuthProvider());
//       } else if (GoogleAuthProvider().providerId == providerData.providerId) {
//         await _auth.currentUser!
//             .reauthenticateWithProvider(GoogleAuthProvider());
//       } else {
//         EmailAuthProvider.credential(
//             email: currentUser.email, password: 'password');
//       }
// // GoogleAuthProvider.credential(idToken: '', accessToken: '')
//       await _auth.currentUser?.delete();
//     } catch (e) {
//       // Handle exceptions
//     }
//   }

  Future<String?> updateEmail(
    String newEmail, {
    required AuthCredential credential,
  }) async {
    try {
      _userCredential =
          await _auth.currentUser?.reauthenticateWithCredential(credential);
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

  Future<(String?, {UserCredential? userCredential})> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          _userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (null, userCredential: userCredential);
    } on FirebaseAuthException catch (e) {
      final errorMsg = const <String, String>{
        'invalid-email': 'Invalid email!',
        'user-disabled': "This email's user is disabled!",
        'user-not-found': "This email's user is not found!",
        'wrong-password': 'Invalid password or unassociated with email!',
      }[e.code];
      return (errorMsg, userCredential: null);
    } catch (e, s) {
      log(_errorMsgSignIn, error: e, stackTrace: s);
      return (_errorMsgSignIn, userCredential: null);
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      _userCredential = null;
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
