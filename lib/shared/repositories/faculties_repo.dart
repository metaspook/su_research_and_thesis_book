import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class FacultiesRepo {
  //-- Config
  final _cacheFaculties = cacheService();
  final _db = FirebaseDatabase.instance.ref('faculties');
  final _errorMsgRoleNotFound = 'User role not found!';
  final _errorMsgRolesNotFound = 'User roles not found!';
  final _errorMsgIndex = "Couldn't get index of the role!";
  final _errorMsgRole = "Couldn't get role of the index!";
  final _errorMsgRoles = "Couldn't get the user roles!";

  //-- Public APIs
  /// Get user role by index.
  // Future<(String?, {String? role})> roleAt(int index) async {
  //   if (_faculties.isEmpty) {
  //     try {
  //       final roleObj = (await _db.child('$index').get()).value;
  //       return roleObj == null
  //           ? (_errorMsgRoleNotFound, role: null)
  //           : (null, role: roleObj.toString());
  //     } catch (e, s) {
  //       log(_errorMsgRole, error: e, stackTrace: s);
  //       return (_errorMsgRole, role: null);
  //     }
  //   }
  //   return (null, role: _faculties[index]);
  // }

  /// Get user role by index.
  // Future<(String?, {int? index})> indexOf(String faculty) async {
  //   final facultiesRecord = await faculties;
  //   return facultiesRecord.faculties.isEmpty
  //       ? (_errorMsgIndex, index: null)
  //       : (null, index: facultiesRecord.faculties.indexOf(faculty));
  // }

  /// Get user faculties.
  Future<(String?, {Map<String, Object?> faculties})> get faculties async {
    String? errorMsg;
    if (_cacheFaculties.isEmpty) {
      try {
        final facultiesObj = (await _db.get()).value;
        facultiesObj != null
            ? _cacheFaculties.addAll(facultiesObj.toJson())
            : errorMsg = _errorMsgRolesNotFound;
      } catch (e, s) {
        log(_errorMsgRoles, error: e, stackTrace: s);
        errorMsg = _errorMsgRoles;
      }
    }
    return (errorMsg, faculties: _cacheFaculties);
  }
}
