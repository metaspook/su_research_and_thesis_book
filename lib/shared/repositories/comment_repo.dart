import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class CommentRepo implements CrudAbstract<Comment> {
  //-- Config
  final _cache = cacheService<String?>();
  final _cachePhoto = cacheService<String?>();
  final _db = FirebaseDatabase.instance.ref('comments');
  final _dbUsers = FirebaseDatabase.instance.ref('users');
  final _errorMsgCreateComment = "Couldn't create the Thesis!";
  final _errorMsgReadThesis = "Couldn't read the Thesis data!";
  final _errorMsgUpdateThesis = "Couldn't update the Thesis!";
  final _errorMsgDeleteThesis = "Couldn't delete the Thesis!";
  final _errorMsgUploadFile = "Couldn't upload the thesis file!";
  final _errorMsgFilePicker = "Couldn't pick the file!";
  final _errorMsgTempFiles = "Couldn't clear the temporary file!";

  //-- Public APIs
  /// Generates a new comment id.
  String get newId => _db.push().key ?? uuid;

  /// Get author name by userId, retrieve from cache if exist.
  Future<String?> authorById(String userId) async =>
      _cache[userId] ??
      (_cache[userId] =
          (await _dbUsers.child('$userId/name').get()).value as String?);

  /// Get author photo by userId, retrieve from cache if exist.
  Future<String?> authorPhotoById(String userId) async =>
      _cachePhoto[userId] ??
      (_cachePhoto[userId] =
          (await _dbUsers.child('$userId/photoUrl').get()).value as String?);

  /// Convert database snapshot to model with logic specified .
  Future<Comment> snapshotToModel(DataSnapshot snapshot) async {
    final commentMap = snapshot.value!.toJson();
    final userId = commentMap['userId']! as String;
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

  Stream<List<Comment>> get stream => _db.onValue.asyncMap<List<Comment>>(
        (event) async => <Comment>[
          for (final e in event.snapshot.children) await snapshotToModel(e),
        ],
      );

  @override
  Future<String?> create(String id, {required Json value}) async {
    try {
      await _db.child(id).set(value);
    } catch (e, s) {
      log(_errorMsgCreateComment, error: e, stackTrace: s);
      return _errorMsgCreateComment;
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
