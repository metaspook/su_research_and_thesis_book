import 'dart:async';
import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class BookmarkRepo {
  //-- Config
  final _cacheThesisBookmarks = const Cache<List<Bookmark>>('thesis_bookmarks');
  final _cacheResearchBookmarks =
      const Cache<List<Bookmark>>('research_bookmarks');
  final _db = FirebaseDatabase.instance.ref('bookmarks');
  final _errorMsgAdd = "Couldn't add the bookmark!";
  final _errorMsgRemove = "Couldn't remove the bookmark!";

  String? get _currentUserId => FirebaseAuth.instance.currentUser?.uid;
  Cache<List<Bookmark>> _cache(PaperType type) => [
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
    final bookmark = await bookmarkByPaper(paper);
    if (bookmark != null) {
      try {
        await _db.child('${paper.type.name}/${bookmark.id}').remove();
      } catch (e, s) {
        log(_errorMsgRemove, error: e, stackTrace: s);
        return _errorMsgRemove;
      }
    }
    return null;
  }

  /// Convert database snapshot to model with logic specified.
  Bookmark? snapshotToModel(DataSnapshot snapshot) {
    final bookmarkMap = snapshot.value?.toJson();
    if (bookmarkMap == null) return null;
    final bookmarkJson = <String, dynamic>{
      'id': snapshot.key,
      'paperId': bookmarkMap['parentId'],
      'userId': bookmarkMap['userId'],
    };
    return Bookmark.fromJson(bookmarkJson);
  }

  Future<Bookmark?> bookmarkByPaper(Paper paper) async {
    final bookmarks = await streamByType(paper.type).first;
    for (final bookmark in bookmarks) {
      if (bookmark.paperId == paper.id) return bookmark;
    }
    return null;
  }

  /// Emits list of bookmarked id.
  Stream<List<Bookmark>> streamByType(PaperType type) async* {
    if (_cache(type).value != null) yield _cache(type).value!;

    yield* _db
        .child(type.name)
        .orderByChild('userId')
        .equalTo(_currentUserId)
        .onValue
        .map<List<Bookmark>>(
      (event) {
        final bookmarks = <Bookmark>[];
        for (final snapshot in event.snapshot.children) {
          final bookmark = snapshotToModel(snapshot);
          if (bookmark != null) bookmarks.add(bookmark);
        }
        return _cache(type).value = bookmarks;
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
