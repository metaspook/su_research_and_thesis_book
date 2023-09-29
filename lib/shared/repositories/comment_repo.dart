import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class CommentRepo implements CrudAbstract<Comment> {
  CommentRepo({required this.thesisId});

  final String thesisId;

  //-- Config
  final _cacheAuthor = cacheService<String?>();
  final _cacheAuthorPhoto = cacheService<String?>();
  final _db = FirebaseDatabase.instance.ref('comments');
  final _dbUsers = FirebaseDatabase.instance.ref('users');
  final _errorMsgCreate = "Couldn't create the Comment!";
  final _errorMsgRead = "Couldn't read the Comment data!";
  final _errorMsgUpdate = "Couldn't update the Comment!";
  final _errorMsgDelete = "Couldn't delete the Comment!";
  final _errorMsgNotFound = 'Comment data not found!';

  //-- Public APIs
  /// Generates a new comment id.
  String get newId => _db.push().key ?? uuid;

  /// Get author name by userId, retrieve from cache if exist.
  Future<String?> authorById(String userId) async =>
      _cacheAuthor[userId] ??
      (_cacheAuthor[userId] =
          (await _dbUsers.child('$userId/name').get()).value as String?);

  /// Get author photo by userId, retrieve from cache if exist.
  Future<String?> authorPhotoById(String userId) async =>
      _cacheAuthorPhoto[userId] ??
      (_cacheAuthorPhoto[userId] =
          (await _dbUsers.child('$userId/photoUrl').get()).value as String?);

  /// Convert database snapshot to model with logic specified .
  Future<Comment?> snapshotToModel(DataSnapshot snapshot) async {
    final commentMap = snapshot.value?.toJson();
    final userId = commentMap?['userId'] as String?;
    if (commentMap == null || userId == null) return null;
    final author = await authorById(userId);
    final authorPhotoUrl = await authorPhotoById(userId);
    final commentJson = <String, Object?>{
      'id': snapshot.key,
      ...commentMap,
      'author': author,
      'authorPhotoUrl': authorPhotoUrl,
    };
    return Comment.fromJson(commentJson);
  }

  Stream<List<Comment>> get stream => _db
          .orderByChild('thesisId')
          .equalTo(thesisId)
          .onValue
          .asyncMap<List<Comment>>(
        (event) async {
          final comments = <Comment>[];
          for (final e in event.snapshot.children) {
            final comment = await snapshotToModel(e);
            if (comment != null) comments.add(comment);
          }
          return comments;
        },
      );

  @override
  Future<String?> create(String id, {required Json value}) async {
    try {
      await _db.child(id).set(value);
    } catch (e, s) {
      log(_errorMsgCreate, error: e, stackTrace: s);
      return _errorMsgCreate;
    }
    return null;
  }

  @override
  Future<String?> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(String?, {Comment? object})> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<String?> update(String id, {required Json value}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
