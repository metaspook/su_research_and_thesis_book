import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/services/services.dart';
import 'package:su_thesis_book/utils/utils.dart';

class DesignationRepo {
  //-- Config
  final _cache = CacheService.global();
  final _db = FirebaseDatabase.instance.ref('designations');
  final _errorMsgDesignationNotFound = 'User designation not found!';
  final _errorMsgDesignationsNotFound = 'User designations not found!';
  final _errorMsgDesignationIndex = "Couldn't get index of the designation!";
  final _errorMsgDesignation = "Couldn't get designation of the index!";
  final _errorMsgDesignations = "Couldn't get the user designations!";

  //-- Public APIs
  /// Get user designations.
  Future<({String? errorMsg, List<String>? designations})>
      get designations async {
    String? errorMsg;
    if ((_cache['designations'] as List<String>? ?? []).isEmpty) {
      try {
        final designationsObj = (await _db.get()).value;
        designationsObj != null
            ? _cache['designations'] = designationsObj.toList<String>()
            : errorMsg = _errorMsgDesignationsNotFound;
      } catch (e, s) {
        log(_errorMsgDesignations, error: e, stackTrace: s);
        errorMsg = _errorMsgDesignations;
      }
    }
    return (
      errorMsg: errorMsg,
      designations: _cache['designations'] as List<String>?
    );
  }
}
