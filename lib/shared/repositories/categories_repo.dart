import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class CategoriesRepo {
  //-- Config
  final _cache = const Cache<List<String>>('categories');
  final _db = FirebaseDatabase.instance.ref('categories');
  final _errorMsgCategoriesNotFound = 'Categories not found!';
  final _errorMsgCategories = "Couldn't get the categories!";

  //-- Public APIs
  /// Get list of categories.
  Future<(String?, List<String>?)> get categories async {
    String? errorMsg;
    if (_cache.isNullOrEmpty) {
      try {
        final categoriesObj = (await _db.get()).value;
        categoriesObj != null
            ? _cache.value = categoriesObj.toList<String>()
            : errorMsg = _errorMsgCategoriesNotFound;
      } catch (e, s) {
        log(_errorMsgCategories, error: e, stackTrace: s);
        errorMsg = _errorMsgCategories;
      }
    }
    return (errorMsg, _cache.value);
  }
}
