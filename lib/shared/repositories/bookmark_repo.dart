import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class BookmarkRepo {
  //-- Config
  final _cacheThesisBookmarks = const Cache<List<String>>('thesis_bookmarks');
  final _cacheResearchBookmarks =
      const Cache<List<String>>('research_bookmarks');
  final _db = FirebaseDatabase.instance.ref('bookmarks');
  final _errorMsgAdd = "Couldn't add the bookmark!";
  final _errorMsgRemove = "Couldn't remove the bookmark!";

  String? get _currentUserId => FirebaseAuth.instance.currentUser?.uid;
  Cache<List<String>> _cache(PaperType type) => [
        _cacheResearchBookmarks,
        _cacheThesisBookmarks,
      ][type.index];
  // Generates a new id.
  String get _newId => _db.push().key ?? uuid;

  //-- Public APIs
  Future<String?> addBookmark(Paper paper) async {
    final value = {'parentId': paper.id, 'userId': _currentUserId};
    try {
      await _db.child('${paper.type.name}/$_newId').set(value);
    } catch (e, s) {
      log(_errorMsgAdd, error: e, stackTrace: s);
      return _errorMsgAdd;
    }
    return null;
  }

  Future<String?> removeBookmark(Paper paper) async {
    try {
      await _db.child('${paper.type.name}/${paper.id}').remove();
    } catch (e, s) {
      log(_errorMsgRemove, error: e, stackTrace: s);
      return _errorMsgRemove;
    }
    return null;
  }

  /// Emits list of bookmarked id.
  Stream<List<String>> ids(PaperType type) async* {
    if (_cache(type).value != null) yield _cache(type).value!;

    yield* _db
        .child(type.name)
        .orderByChild('userId')
        .equalTo(_currentUserId)
        .onValue
        .map<List<String>>(
      (event) {
        final paperIds = <String>[];
        for (final snapshot in event.snapshot.children) {
          final bookmarkMap = snapshot.value?.toJson();
          final paperId = bookmarkMap?['parentId'] as String?;
          if (paperId != null) paperIds.add(paperId);
        }
        return _cache(type).value = paperIds;
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
