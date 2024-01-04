import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class DesignationsRepo {
  //-- Config
  final _cache = const Cache<List<String>>('designations');
  final _db = FirebaseDatabase.instance.ref('designations');
  final _errorMsgDesignationsNotFound = 'Designations not found!';
  final _errorMsgDesignations = "Couldn't get the designations!";

  //-- Public APIs
  /// Get list of designation.
  Future<(String?, List<String>?)> get designations async {
    String? errorMsg;
    if (_cache.isNullOrEmpty) {
      try {
        final designationsObj = (await _db.get()).value;
        designationsObj != null
            ? _cache.value = designationsObj.toList<String>()
            : errorMsg = _errorMsgDesignationsNotFound;
      } catch (e, s) {
        log(_errorMsgDesignations, error: e, stackTrace: s);
        errorMsg = _errorMsgDesignations;
      }
    }
    return (errorMsg, _cache.value);
  }
}
