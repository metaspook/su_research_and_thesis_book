import 'dart:async';
import 'dart:developer';

import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

//  AppUser? _user;
final _userController = StreamController<AppUser?>();

class AppUserRepo extends DatabaseRepo {
  const AppUserRepo();

  // Public APIs
  Stream<AppUser?> get appUserStream => _userController.stream;
  void addUser(AppUser? user) => _userController.add(user);
  void dispose() => _userController.close();

  @override
  Future<bool> create(Map<String, dynamic> value) async {
    try {
      // if (_user != null) {
      await db.set(value);
      return true;
      // }
    } catch (e, s) {
      log("Couldn't create user", error: e, stackTrace: s);
    }
    return false;
  }

  @override
  Future<bool> read(String id) async {
    try {
      final dbUserObj = (await db.child(id).get()).value;
      if (dbUserObj != null) {
        final appUser = AppUser.fromFirebaseObj(dbUserObj, id: id);
        addUser(appUser);
      }
      return true;
    } catch (e, s) {
      log("Couldn't read user", error: e, stackTrace: s);
    }
    return false;
  }

  @override
  Future<bool> update(Map<String, Object?> value) async {
    // try {
    //   if (_user != null) {
    //     await db.child(_user!.id).update(value);
    //     return true;
    //   }
    // } catch (e, s) {
    //   log("Couldn't update user", error: e, stackTrace: s);
    // }
    return false;
  }

  @override
  Future<bool> delete(String id) async {
    // try {
    //   if (_user != null) {
    //     await db.child(_user!.id).remove();
    //     return true;
    //   }
    // } catch (e, s) {
    //   log("Couldn't delete user", error: e, stackTrace: s);
    // }
    return false;
  }

  @override
  String get dbPath => 'users';

  // FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  // Public APIs
  // Stream<models.User?> get userStream => _userController.stream;
  // Stream<User?> get authUserStream => _firebaseAuth.authStateChanges();
  // void addUser(models.User user) => _userController.add(user);
  // void dispose() => _userController.close();
  // // StreamController<models.User> get userController => _userController;
}
