import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class AppUserRepo implements CrudAbstract<AppUser> {
  //-- Config
  final _db = FirebaseDatabase.instance.ref('users');
  final _dbRoles = FirebaseDatabase.instance.ref('roles');
  final _storage = FirebaseStorage.instance.ref('photos');
  final _errorMsgCreate = "Couldn't create the User!";
  final _errorMsgRead = "Couldn't read the User data!";
  final _errorMsgUpdate = "Couldn't update the User!";
  final _errorMsgDelete = "Couldn't delete the User!";
  final _errorMsgNotFound = 'User data not found!';
  final _errorMsgRole = "Couldn't get role of the index!";
  final _errorMsgUserPhoto = "Couldn't upload the User photo!";

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

  /// Get user's full name by id.
  Future<String?> nameById(String userId) async =>
      (await _db.child('$userId/name').get()).value as String?;

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
      log(_errorMsgCreate, error: e, stackTrace: s);
      return _errorMsgCreate;
    }
    return null;
  }

  /// Get user role by index.
  Future<String?> roleByIndex(int index) async {
    final roleObj = (await _dbRoles.child('$index').get()).value;
    return roleObj?.toString();
  }

  /// Convert database snapshot to model with logic specified .
  Future<AppUser?> snapshotToModel(DataSnapshot snapshot) async {
    final userMap = snapshot.value?.toJson();
    final userRoleIndex = userMap?['roleIndex'] as int?;
    if (userMap == null || userRoleIndex == null) return null;
    final userRole = await roleByIndex(userRoleIndex);
    final userJson = <String, Object?>{
      'id': snapshot.key,
      ...userMap,
      'role': userRole,
    };
    return AppUser.fromJson(userJson);
  }

  /// Read user data from database.
  @override
  Future<(String?, {AppUser object})> read(String userId) async {
    try {
      // Download user data from DB.
      final snapshot = await _db.child(userId).get();
      final appUser = await snapshotToModel(snapshot);
      if (appUser == null) return (_errorMsgNotFound, object: AppUser.empty);
      return (null, object: appUser);
    } catch (e, s) {
      log(_errorMsgRead, error: e, stackTrace: s);
      return (_errorMsgRead, object: AppUser.empty);
    }
  }

  /// Update user data to database.
  @override
  Future<String?> update(String userId, {required Json value}) async {
    try {
      await _db.child(userId).update(value);
    } catch (e, s) {
      log(_errorMsgUpdate, error: e, stackTrace: s);
      return _errorMsgUpdate;
    }
    return null;
  }

  /// Delete user data from database.
  @override
  Future<String?> delete(String userId) async {
    try {
      await _db.child(userId).remove();
    } catch (e, s) {
      log(_errorMsgDelete, error: e, stackTrace: s);
      return _errorMsgDelete;
    }
    return null;
  }
}
