import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

class DepartmentsRepo {
  //-- Config
  final _cache = const Cache<List<String>>('departments');
  final _db = FirebaseDatabase.instance.ref('departments');
  final _errorMsgDepartmentsNotFound = 'Departments not found!';
  final _errorMsgDepartments = "Couldn't get the departments!";

  //-- Public APIs
  /// Get list of departments.
  Future<(String?, List<String>?)> get departments async {
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
    return (errorMsg, _cache.value);
  }
}
