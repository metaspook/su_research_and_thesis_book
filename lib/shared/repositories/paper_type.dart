import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class PaperTypeRepo {
  //-- Config
  final _cache = const Cache<List<String>>('paperTypes');
  final _db = FirebaseDatabase.instance.ref('paperTypes');
  final _errorMsgDepartmentsNotFound = 'Paper types not found!';
  final _errorMsgDepartments = "Couldn't get the paper types!";

  //-- Public APIs
  /// Get list of paper types.
  Future<(String?, List<String>?)> get paperTypes async {
    String? errorMsg;
    if (_cache.isNullOrEmpty) {
      try {
        final paperTypesObj = (await _db.get()).value;
        paperTypesObj != null
            ? _cache.value = paperTypesObj.toList<String>()
            : errorMsg = _errorMsgDepartmentsNotFound;
      } catch (e, s) {
        log(_errorMsgDepartments, error: e, stackTrace: s);
        errorMsg = _errorMsgDepartments;
      }
    }
    return (errorMsg, _cache.value);
  }
  // Future<(String?, List<Paper>?)> get paperTypes async {
  //   String? errorMsg;
  //   if (_cache.isNullOrEmpty) {
  //     try {
  //       final paperTypesObj = (await _db.get()).value;
  //       paperTypesObj != null
  //           ? _cache.value = paperTypesObj
  //               .toList<String>()
  //               .map<Paper>(Paper.values.byName)
  //               .toList()
  //           : errorMsg = _errorMsgDepartmentsNotFound;
  //     } catch (e, s) {
  //       log(_errorMsgDepartments, error: e, stackTrace: s);
  //       errorMsg = _errorMsgDepartments;
  //     }
  //   }
  //   return (errorMsg, _cache.value);
  // }
}
