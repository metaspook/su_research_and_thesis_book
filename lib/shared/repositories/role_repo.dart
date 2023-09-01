import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

final _firebaseDatabase = FirebaseDatabase.instance;
// ignore: use_late_for_private_fields_and_variables
String? _errorMsg;
List<String> _roles = const [];

class RoleRepo {
  const RoleRepo();

  DatabaseReference get _db => _firebaseDatabase.ref('roles');
  String? get errorMsg => _errorMsg;

  /// Get user role by index.
  Future<String?> roleAt(int index) async {
    if (_roles.isEmpty) {
      try {
        final roleObj = (await _db.child('$index').get()).value;
        if (roleObj != null) return roleObj.toString();
        _errorMsg = 'User role not found!';
      } catch (e, s) {
        _errorMsg = "Couldn't get the user role!";
        log("Couldn't fetch the user role!", error: e, stackTrace: s);
      }
    }

    return _roles[index];
  }

  /// Get user role by index.
  Future<int?> indexOf(String role) async {
    final roles_ = await roles;
    return roles_.isEmpty ? null : roles_.indexOf(role);
  }

  /// Get user roles.
  Future<List<String>> get roles async {
    if (_roles.isEmpty) {
      try {
        final rolesObj = (await _db.get()).value;
        // rolesObj.doPrint();
        if (rolesObj != null) _roles = rolesObj.toList<String>();
        _errorMsg = 'User roles not found!';
      } catch (e, s) {
        _errorMsg = "Couldn't get the user roles!";
        log("Couldn't fetch the user roles!", error: e, stackTrace: s);
      }
    }

    return _roles;
  }
}
