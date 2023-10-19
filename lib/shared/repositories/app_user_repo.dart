import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class AppUserRepo implements CrudAbstract<AppUser> {
  //-- Config
  final _cache = cacheService<List<String>>();
  final _db = FirebaseDatabase.instance.ref('users');
  final _storage = FirebaseStorage.instance.ref('photos');
  final _errorMsgCreate = "Couldn't create the User!";
  final _errorMsgRead = "Couldn't read the User data!";
  final _errorMsgUpdate = "Couldn't update the User!";
  final _errorMsgDelete = "Couldn't delete the User!";
  final _errorMsgNotFound = 'User data not found!';
  final _errorMsgUserPhoto = "Couldn't upload the User photo!";
  // - Roles Config
  final _dbRoles = FirebaseDatabase.instance.ref('roles');
  final _errorMsgRoleNotFound = 'User role not found!';
  final _errorMsgRolesNotFound = 'User roles not found!';
  final _errorMsgRoleIndex = "Couldn't get index of the role!";
  final _errorMsgRole = "Couldn't get role of the index!";
  final _errorMsgRoles = "Couldn't get the user roles!";
  // - Departments Config
  final _dbDepartments = FirebaseDatabase.instance.ref('departments');
  final _errorMsgDepartmentNotFound = 'User department not found!';
  final _errorMsgDepartmentsNotFound = 'User departments not found!';
  final _errorMsgDepartmentIndex = "Couldn't get index of the department!";
  final _errorMsgDepartment = "Couldn't get department of the index!";
  final _errorMsgDepartments = "Couldn't get the user departments!";

  //-- Public APIs
  /// Get user roles.
  Future<({String? errorMsg, List<String>? roles})> get roles async {
    String? errorMsg;
    if ((_cache['roles'] ?? []).isEmpty) {
      try {
        final rolesObj = (await _dbRoles.get()).value;
        rolesObj != null
            ? _cache['roles'] = rolesObj.toList<String>()
            : errorMsg = _errorMsgRolesNotFound;
      } catch (e, s) {
        log(_errorMsgRoles, error: e, stackTrace: s);
        errorMsg = _errorMsgRoles;
      }
    }
    return (errorMsg: errorMsg, roles: _cache['roles']);
  }

  /// Get user departments.
  Future<({String? errorMsg, List<String>? departments})>
      get departments async {
    String? errorMsg;
    if ((_cache['departments'] ?? []).isEmpty) {
      try {
        final departmentsObj = (await _dbDepartments.get()).value;
        departmentsObj != null
            ? _cache['departments'] = departmentsObj.toList<String>()
            : errorMsg = _errorMsgDepartmentsNotFound;
      } catch (e, s) {
        log(_errorMsgDepartments, error: e, stackTrace: s);
        errorMsg = _errorMsgDepartments;
      }
    }
    return (errorMsg: errorMsg, departments: _cache['departments']);
  }

  /// Upload user photo to Storage and get URL.
  Future<({String? errorMsg, String? photoUrl})> uploadPhoto(
    String path, {
    required String userId,
  }) async {
    try {
      final storageRef = _storage.child('$userId.jpg');
      await storageRef.putFile(File(path));
      final photoUrl = await storageRef.getDownloadURL();
      return (errorMsg: null, photoUrl: photoUrl);
    } catch (e, s) {
      log(_errorMsgUserPhoto, error: e, stackTrace: s);
      return (errorMsg: _errorMsgUserPhoto, photoUrl: null);
    }
  }

  /// Get user's full name by id.
  Future<String?> nameById(String userId) async =>
      (await _db.child('$userId/name').get()).value as String?;

  /// Create user data to database.
  @override
  Future<String?> create(String userId, {required Json value}) async {
    try {
      // Upload user data to DB.
      await _db.child(userId).set(value);
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
