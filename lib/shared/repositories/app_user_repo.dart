import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

//  AppUser? _user;
final _userController = StreamController<AppUser?>();

class AppUserRepo extends FirebaseRepo {
  const AppUserRepo();

  // Public APIs
  Stream<AppUser?> get appUserStream => _userController.stream;
  void addUser(AppUser? user) => _userController.add(user);
  void dispose() => _userController.close();

  @override
  Future<String?> create(Json value) async {
    try {
      // Create auth user and set UID.
      final userId = (await auth.createUserWithEmailAndPassword(
        email: value['email']! as String,
        password: value['password']! as String,
      ))
          .user!
          .uid;
      // Upload user photo to Storage and get URL.
      final storageRef = storage.child('$userId.jpg')
        ..putFile(File(value['photoUrl']! as String));
      final photoUrl = await storageRef.getDownloadURL();
      // Get user role by index.
      final rolesObj = (await rolesRef.get()).value!;
      // final roleIndex = value['id'][''];
      final role = List<dynamic>.from(rolesObj as List<Object?>);
      // Upload user data to DB.
      await db.set({
        userId: {
          'name': value['photoUrl'],
          'email': value['photoUrl'],
          'roleIndex': value['role'],
          'phone': value['phone'],
          'photoUrl': photoUrl,
        },
      });
    } on FirebaseAuthException catch (e) {
      return switch (e.code) {
        'weak-password' => 'The password provided is too weak.',
        'email-already-in-use' => 'The account already exists for that email.',
        _ => '',
      };
    } catch (e, s) {
      log("Couldn't create user", error: e, stackTrace: s);
    }

    return null;

    // } catch (e, s) {
    //   log("Couldn't sign-up user", error: e, stackTrace: s);
    // }

    // try {
    //   // if (_user != null) {
    //   await db.set(value);
    //   FirebaseStorage.
    //   return true;
    //   // }
    // } catch (e, s) {
    //   log("Couldn't create user", error: e, stackTrace: s);
    // }
    // return false;
  }

  @override
  Future<String?> read(String id) async {
    return null;

    // try {
    //   final dbUserObj = (await db.child(id).get()).value;
    //   if (dbUserObj != null) {
    //     final appUser = AppUser.fromFirebaseObj(dbUserObj, id: id);
    //     addUser(appUser);
    //   }
    //   return true;
    // } catch (e, s) {
    //   log("Couldn't read user", error: e, stackTrace: s);
    // }
    // return false;
  }

  @override
  Future<String?> update(Json value) async {
    return null;

    // try {
    //   if (_user != null) {
    //     await db.child(_user!.id).update(value);
    //     return true;
    //   }
    // } catch (e, s) {
    //   log("Couldn't update user", error: e, stackTrace: s);
    // }
    // return false;
  }

  @override
  Future<String?> delete(String id) async {
    return null;
    // try {
    //   if (_user != null) {
    //     await db.child(_user!.id).remove();
    //     return true;
    //   }
    // } catch (e, s) {
    //   log("Couldn't delete user", error: e, stackTrace: s);
    // }
    // return false;
  }

  @override
  String get dbPath => 'users';

  @override
  String get storagePath => 'photos';

  // FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  // Public APIs
  // Stream<models.User?> get userStream => _userController.stream;
  // Stream<User?> get authUserStream => _firebaseAuth.authStateChanges();
  // void addUser(models.User user) => _userController.add(user);
  // void dispose() => _userController.close();
  // // StreamController<models.User> get userController => _userController;
}

//  // Create new user and set UID.
//         await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//               email: XController.email.text,
//               password: XController.password.text,
//             )
//             .then((userCredential) => _userId = userCredential.user!.uid);
//         // Set User DB and Storage references.
//         final dbRef = Database.dbRealtime.ref("users/$_userId");
//         final storageRef =
//             FirebaseStorage.instance.ref("images/users/$_userId.jpg");
//         // Upload User image to Storage.
//         await storageRef.putFile(_imageFile!);
//         // Upload User data to DB.
//         await dbRef.set({
//           "id": _userId,
//           "fullName": XController.fullName.text,
//           "email": XController.email.text,
//           "password": XController.password.text,
//           "phone": XController.phone.text,
//           "address": XController.address.text,
//           "image": await storageRef.getDownloadURL(),
//         });
//         XController.fullName.clear();
//         XController.phone.clear();
//         XController.address.clear();
//       } on FirebaseAuthException catch (err) {
//         switch (err.code) {
//           case 'weak-password':
//             return "The password provided is too weak.";
//           case 'email-already-in-use':
//             return "The account already exists for that email.";
//         }
//       } catch (err) {
//         return err.toString();
//       }