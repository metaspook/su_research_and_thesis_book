import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/services/services.dart';
import 'package:su_thesis_book/utils/utils.dart';

class DepartmentRepo {
  //-- Config
  final _cache = const Cache<List<String>>('departments');
  final _db = FirebaseDatabase.instance.ref('departments');
  final _errorMsgDepartmentNotFound = 'User department not found!';
  final _errorMsgDepartmentsNotFound = 'User departments not found!';
  final _errorMsgDepartmentIndex = "Couldn't get index of the department!";
  final _errorMsgDepartment = "Couldn't get department of the index!";
  final _errorMsgDepartments = "Couldn't get the user departments!";

  //-- Public APIs
  /// Get departments.
  Future<({String? errorMsg, List<String>? departments})>
      get departments async {
    String? errorMsg;

    if (_cache.isNullOrEmpty) {
      try {
        final departmentsObj = (await _db.get()).value;
        departmentsObj != null
            ? _cache.value = departmentsObj.toList<String>()
            : errorMsg = _errorMsgDepartmentsNotFound;
      } catch (e, s) {
        log(_errorMsgDepartments, error: e, stackTrace: s);
        errorMsg = _errorMsgDepartments;
      }
    }
    return (errorMsg: errorMsg, departments: _cache.value);
  }
}
