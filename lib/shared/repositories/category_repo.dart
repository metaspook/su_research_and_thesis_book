import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/utils/utils.dart';

class CategoryRepo {
  //-- Config
  final _cache = const Cache<List<String>>('categories');
  final _db = FirebaseDatabase.instance.ref('categories');
  final _errorMsgCategoryNotFound = 'User category not found!';
  final _errorMsgCategoriesNotFound = 'User categories not found!';
  final _errorMsgCategoryIndex = "Couldn't get index of the category!";
  final _errorMsgCategory = "Couldn't get category of the index!";
  final _errorMsgCategories = "Couldn't get the user categories!";

  //-- Public APIs
  /// Get categories.
  Future<({String? errorMsg, List<String>? categories})> get categories async {
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
    return (errorMsg: errorMsg, categories: _cache.value);
  }
}
