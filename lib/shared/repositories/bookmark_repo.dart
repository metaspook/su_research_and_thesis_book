import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class BookmarkRepo {
  //-- Config
  final _cache = const Cache<Map<String, List<String>>>('bookmarks');
  final _db = FirebaseDatabase.instance.ref('bookmarks');
  final _currentUserId = FirebaseAuth.instance.currentUser?.uid;
  final _errorMsgAdd = "Couldn't add the bookmark!";
  final _errorMsgRemove = "Couldn't remove the bookmark!";

  // Generates a new id.
  String get _newId => _db.push().key ?? uuid;

  //-- Public APIs
  Future<String?> addBookmark(
    PaperType type, {
    required String theseId,
  }) async {
    final value = {'parentId': theseId, 'userId': _currentUserId};
    try {
      await _db.child('${type.name}/$_newId').set(value);
    } catch (e, s) {
      log(_errorMsgAdd, error: e, stackTrace: s);
      return _errorMsgAdd;
    }
    return null;
  }

  Future<String?> removeBookmark(
    PaperType type, {
    required String id,
  }) async {
    try {
      await _db.child('${type.name}/$id').remove();
    } catch (e, s) {
      log(_errorMsgRemove, error: e, stackTrace: s);
      return _errorMsgRemove;
    }
    return null;
  }

  /// Emits list of bookmarked id.
  Stream<List<String>> ids(PaperType type) async* {
    if (_cache.value?[type.name] != null) yield _cache.value![type.name]!;

    yield* _db
        .child(type.name)
        .orderByChild('userId')
        .equalTo(_currentUserId)
        .onValue
        .map<List<String>>(
      (event) {
        final thesisIds = <String>[];
        for (final snapshot in event.snapshot.children) {
          final bookmarkMap = snapshot.value?.toJson();
          final thesisId = bookmarkMap?['parentId'] as String?;
          if (thesisId != null) thesisIds.add(thesisId);
        }
        return _cache.value![type.name] = thesisIds;
      },
    );
  }
}


  // Stream<List<Thesis>> get bookmarks async* {
  //   if (_cache.value != null) yield _cache.value!;

  //   yield* _dbBookmarks
  //       .orderByChild('userId')
  //       .equalTo(_currentUserId)
  //       .onValue
  //       .asyncMap<List<Thesis>>(
  //     (event) async {
  //       final thesisIds = <String>[];
  //       for (final snapshot in event.snapshot.children) {
  //         final bookmarkMap = snapshot.value?.toJson();
  //         final thesisId = bookmarkMap?['parentId'] as String?;
  //         if (thesisId != null) thesisIds.add(thesisId);
  //       }
  //       final theses = await stream.first;
  //       return [...theses.where((e) => thesisIds.contains(e.id))];
  //     },
  //   );
