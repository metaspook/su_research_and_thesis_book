import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class RoleRepo {
  //-- Config
  final _cache = cacheService<List<String>>();
  final _db = FirebaseDatabase.instance.ref('roles');
  final _errorMsgRoleNotFound = 'User role not found!';
  final _errorMsgRolesNotFound = 'User roles not found!';
  final _errorMsgIndex = "Couldn't get index of the role!";
  final _errorMsgRole = "Couldn't get role of the index!";
  final _errorMsgRoles = "Couldn't get the user roles!";

  //-- Public APIs
  /// Get role at a index number.
  Future<(String?, {String? role})> roleAt(int index) async {
    if ((_cache['roles'] ?? []).isEmpty) {
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
    return (null, role: _cache['roles']?[index]);
  }

  /// Get index number of a role.
  Future<(String?, {int? index})> indexOf(String role) async {
    final rolesRecord = await roles;
    return (rolesRecord.roles ?? []).isEmpty
        ? (_errorMsgIndex, index: null)
        : (null, index: rolesRecord.roles?.indexOf(role));
  }

  /// Get user roles.
  Future<(String?, {List<String>? roles})> get roles async {
    String? errorMsg;
    if ((_cache['roles'] ?? []).isEmpty) {
      try {
        final rolesObj = (await _db.get()).value;
        rolesObj != null
            ? _cache['roles'] = rolesObj.toList<String>()
            : errorMsg = _errorMsgRolesNotFound;
      } catch (e, s) {
        log(_errorMsgRoles, error: e, stackTrace: s);
        errorMsg = _errorMsgRoles;
      }
    }
    return (errorMsg, roles: _cache['roles']);
  }
}
