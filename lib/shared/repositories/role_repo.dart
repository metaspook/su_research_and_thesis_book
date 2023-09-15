import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class RoleRepo {
  const RoleRepo();

  //-- Config
  static final _db = FirebaseDatabase.instance.ref('roles');
  static const _errorMsgRoleNotFound = 'User role not found!';
  static const _errorMsgRolesNotFound = 'User roles not found!';
  static const _errorMsgIndex = "Couldn't get index of the role!";
  static const _errorMsgRole = "Couldn't get role of the index!";
  static const _errorMsgRoles = "Couldn't get the user roles!";
  // user roles cache.
  static List<String> _roles = const [];

  //-- Public APIs
  /// Get user role by index.
  Future<(String?, {String? role})> roleAt(int index) async {
    if (_roles.isEmpty) {
      try {
        final roleObj = (await _db.child('$index').get()).value;
        return roleObj == null
            ? (_errorMsgRoleNotFound, role: null)
            : (null, role: roleObj.toString());
      } catch (e, s) {
        log(_errorMsgRole, error: e, stackTrace: s);
        return (_errorMsgRole, role: null);
      }
    }
    return (null, role: _roles[index]);
  }

  /// Get user role by index.
  Future<(String?, {int? index})> indexOf(String role) async {
    final rolesRecord = await roles;
    return rolesRecord.roles.isEmpty
        ? (_errorMsgIndex, index: null)
        : (null, index: rolesRecord.roles.indexOf(role));
  }

  /// Get user roles.
  Future<(String?, {List<String> roles})> get roles async {
    String? errorMsg;
    if (_roles.isEmpty) {
      try {
        final rolesObj = (await _db.get()).value;
        if (rolesObj != null) _roles = rolesObj.toList<String>();
        errorMsg = _errorMsgRolesNotFound;
      } catch (e, s) {
        log(_errorMsgRoles, error: e, stackTrace: s);
        errorMsg = _errorMsgRoles;
      }
    }
    return (errorMsg, roles: _roles);
  }
}
