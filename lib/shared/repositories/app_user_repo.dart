import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class AppUserRepo implements CrudAbstract<AppUser> {
  const AppUserRepo();

  //-- Config
  static final _db = FirebaseDatabase.instance.ref('users');
  static final _storage = FirebaseStorage.instance.ref('photos');
  static const _errorMsgCreateUser = "Couldn't create the User!";
  static const _errorMsgReadUser = "Couldn't read the User data!";
  static const _errorMsgUpdateUser = "Couldn't update the User!";
  static const _errorMsgDeleteUser = "Couldn't delete the User!";
  static const _errorMsgUserPhoto = "Couldn't upload the User photo!";

  //-- Public APIs
  /// Upload user photo to Storage and get URL.
  Future<(String?, {String? photoUrl})> uploadPhoto(
    String path, {
    required String userId,
  }) async {
    try {
      final storageRef = _storage.child('$userId.jpg');
      await storageRef.putFile(File(path));
      final photoUrl = await storageRef.getDownloadURL();
      return (null, photoUrl: photoUrl);
    } catch (e, s) {
      log(_errorMsgUserPhoto, error: e, stackTrace: s);
      return (_errorMsgUserPhoto, photoUrl: null);
    }
  }

  /// Create user data to database.
  @override
  Future<String?> create(String userId, {required Json value}) async {
    try {
      // Upload user photo to storage.
      final uploadRecord =
          await uploadPhoto(value['photoPath']! as String, userId: userId);
      final errorMsg = uploadRecord.$1;
      if (errorMsg != null) return errorMsg;
      // Upload user data to DB.
      await _db.child(userId).set({
        'name': value['name'],
        'email': value['email'],
        'roleIndex': value['roleIndex'],
        'phone': value['phone'],
        'photoUrl': uploadRecord.photoUrl,
      });
    } catch (e, s) {
      log(_errorMsgCreateUser, error: e, stackTrace: s);
      return _errorMsgCreateUser;
    }
    return null;
  }

  /// Read user data from database.
  @override
  Future<(String?, {AppUser object})> read(String userId) async {
    try {
      // Download user data from DB.
      final userObj = (await _db.child(userId).get()).value;
      if (userObj == null) {
        return ('User data not found!', object: AppUser.empty);
      }
      final userMap = userObj.toMap<String, Object>();
      // Convert user data to model.
      final user = AppUser.fromJson({'id': userId, ...userMap});
      return (null, object: user);
    } catch (e, s) {
      log(_errorMsgReadUser, error: e, stackTrace: s);
      return (_errorMsgReadUser, object: AppUser.empty);
    }
  }

  /// Update user data to database.
  @override
  Future<String?> update(String userId, {required Json value}) async {
    try {
      await _db.child(userId).update(value);
    } catch (e, s) {
      log(_errorMsgUpdateUser, error: e, stackTrace: s);
      return _errorMsgUpdateUser;
    }
    return null;
  }

  /// Delete user data from database.
  @override
  Future<String?> delete(String userId) async {
    try {
      await _db.child(userId).remove();
    } catch (e, s) {
      log(_errorMsgDeleteUser, error: e, stackTrace: s);
      return _errorMsgDeleteUser;
    }
    return null;
  }
}
