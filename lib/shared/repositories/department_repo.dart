import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class DepartmentRepo {
  //-- Config
  final _cache = cacheService<List<String>>();
  final _db = FirebaseDatabase.instance.ref('departments');
  final _errorMsgDepartmentNotFound = 'User department not found!';
  final _errorMsgDepartmentsNotFound = 'User departments not found!';
  final _errorMsgIndex = "Couldn't get index of the department!";
  final _errorMsgDepartment = "Couldn't get department of the index!";
  final _errorMsgDepartments = "Couldn't get the user departments!";

  //-- Public APIs
  /// Get department at a index number.
  Future<(String?, {String? department})> departmentAt(int index) async {
    if ((_cache['departments'] ?? []).isEmpty) {
      try {
        final departmentObj = (await _db.child('$index').get()).value;
        return departmentObj == null
            ? (_errorMsgDepartmentNotFound, department: null)
            : (null, department: departmentObj.toString());
      } catch (e, s) {
        log(_errorMsgDepartment, error: e, stackTrace: s);
        return (_errorMsgDepartment, department: null);
      }
    }
    return (null, department: _cache['departments']?[index]);
  }

  /// Get index number of a department.
  Future<(String?, {int? index})> indexOf(String department) async {
    final departmentsRecord = await departments;
    return (departmentsRecord.departments ?? []).isEmpty
        ? (_errorMsgIndex, index: null)
        : (null, index: departmentsRecord.departments?.indexOf(department));
  }

  /// Get user departments.
  Future<(String?, {List<String>? departments})> get departments async {
    String? errorMsg;
    if ((_cache['departments'] ?? []).isEmpty) {
      try {
        final departmentsObj = (await _db.get()).value;
        departmentsObj != null
            ? _cache['departments'] = departmentsObj.toList<String>()
            : errorMsg = _errorMsgDepartmentsNotFound;
      } catch (e, s) {
        log(_errorMsgDepartments, error: e, stackTrace: s);
        errorMsg = _errorMsgDepartments;
      }
    }
    return (errorMsg, departments: _cache['departments']);
  }
}
