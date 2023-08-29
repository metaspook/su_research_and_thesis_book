import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

final _firebaseDatabase = FirebaseDatabase.instance;
String _errorMsg = '';

class RoleRepo {
  const RoleRepo();

  DatabaseReference get _db => _firebaseDatabase.ref('roles');
  String get errorMsg => _errorMsg;

  /// Get user role by index.
  Future<String?> roleAt(int index) async {
    try {
      final roleObj = (await _db.child('$index').get()).value;
      if (roleObj != null) return roleObj.toString();
      _errorMsg = 'User role not found!';
    } catch (e, s) {
      _errorMsg = "Couldn't get the user role!";
      log("Couldn't fetch the user role!", error: e, stackTrace: s);
    }
    return null;
  }

  /// Get user roles.
  Future<List<int>> get roles async {
    try {
      final rolesObj = (await _db.get()).value;
      if (rolesObj != null) return rolesObj.toList<int>();
      _errorMsg = 'User roles not found!';
    } catch (e, s) {
      _errorMsg = "Couldn't get the user roles!";
      log("Couldn't fetch the user roles!", error: e, stackTrace: s);
    }
    return const <int>[];
  }
}
