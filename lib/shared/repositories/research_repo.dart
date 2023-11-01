import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ResearchRepo implements CrudAbstract<Research> {
  //-- Config
  final _cacheAuthor = cacheService<String?>();
  final _cacheAuthorPhoto = cacheService<String?>();
  final _db = FirebaseDatabase.instance.ref('researches');
  final _dbUsers = FirebaseDatabase.instance.ref('users');
  final _storage = FirebaseStorage.instance.ref('researches');
  final _filePicker = FilePicker.platform;
  final _errorMsgCreate = "Couldn't create the Research!";
  final _errorMsgRead = "Couldn't read the Research data!";
  final _errorMsgUpdate = "Couldn't update the Research!";
  final _errorMsgDelete = "Couldn't delete the Research!";
  // final _errorMsgNotFound = 'Thesis data not found!';
  final _errorMsgUploadFile = "Couldn't upload the research file!";
  final _errorMsgFilePicker = "Couldn't pick the file!";
  final _errorMsgTempFiles = "Couldn't clear the temporary file!";

  // pick files.
  Future<({String? errorMsg, FilePickerResult? result})> _pickFile() async {
    final result = await _filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result == null
        ? (errorMsg: _errorMsgFilePicker, result: null)
        : (errorMsg: null, result: result);
  }

  //-- Public APIs
  /// Generates a new research id.
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
  Future<Research?> snapshotToModel(DataSnapshot snapshot) async {
    final researchMap = snapshot.value?.toJson();
    final userId = researchMap?['userId'] as String?;
    if (researchMap == null || userId == null) return null;
    final author = await authorById(userId);
    final authorPhotoUrl = await authorPhotoById(userId);
    final researchJson = <String, Object?>{
      'id': snapshot.key,
      ...researchMap,
      'author': author,
      'authorPhotoUrl': authorPhotoUrl,
    };
    return Research.fromJson(researchJson);
  }

  Stream<List<Research>> get stream => _db.onValue.asyncMap<List<Research>>(
        (event) async {
          final researches = <Research>[];
          for (final e in event.snapshot.children) {
            final research = await snapshotToModel(e);
            if (research != null) researches.add(research);
          }
          return researches;
        },
      );

  /// Upload research file to Storage and get URL.
  Future<({String? errorMsg, String? fileUrl})> uploadFile(String path) async {
    try {
      final file = File(path);
      final fileName = file.uri.pathSegments.last;
      final storageRef = _storage.child(fileName);
      await storageRef.putFile(file);
      final fileUrl = await storageRef.getDownloadURL();
      return (errorMsg: null, fileUrl: fileUrl);
    } catch (e, s) {
      log(_errorMsgUploadFile, error: e, stackTrace: s);
      return (errorMsg: _errorMsgUploadFile, fileUrl: null);
    }
  }

  /// Clear temporary picked files.
  Future<String?> clearTemp() async =>
      (await _filePicker.clearTemporaryFiles() ?? false)
          ? null
          : _errorMsgTempFiles;

  Future<({String? errorMsg, String? path})> pickToPath() async {
    final pickFileRecord = await _pickFile();
    return (
      errorMsg: pickFileRecord.errorMsg,
      path: pickFileRecord.result?.files.first.path
    );
  }

  // useful for web and Image.memory widget.
  Future<({String? errorMsg, Uint8List? bytes})> pickToBytes() async {
    final pickFileRecord = await _pickFile();
    return (
      errorMsg: pickFileRecord.errorMsg,
      bytes: pickFileRecord.result?.files.first.bytes
    );
  }

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
  Future<String?> delete(String id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(String?, {Research? object})> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<String?> update(String id, {required Json value}) async {
    try {
      await _db.child(id).update(value);
    } catch (e, s) {
      log(_errorMsgUpdate, error: e, stackTrace: s);
      return _errorMsgUpdate;
    }
    return null;
  }
}
