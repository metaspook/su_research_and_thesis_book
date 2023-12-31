import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ResearchRepo implements CRUD<Research> {
  //-- Config
  final _cacheDesignations = const Cache<List<String>>('designations');
  final _cacheCategories = const Cache<List<String>>('categories');
  final _cacheDepartments = const Cache<List<String>>('departments');
  final _cache = const Cache<List<Research>>('researches');
  final _db = FirebaseDatabase.instance.ref('researches');
  final _dbUsers = FirebaseDatabase.instance.ref('users');
  final _storage = FirebaseStorage.instance.ref('researches');
  final _filePicker = FilePicker.platform;
  final _errorMsgCreate = "Couldn't create the Research!";
  final _errorMsgRead = "Couldn't read the Research data!";
  final _errorMsgUpdate = "Couldn't update the Research!";
  final _errorMsgDelete = "Couldn't delete the Research!";
  // final _errorMsgNotFound = 'Research data not found!';
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

  /// Get publisher by userId.
  Future<Publisher?> publisherById(String id) async {
    final snapshot = await _dbUsers.child(id).get();
    final publisherMap = snapshot.value?.toJson();
    final designationIndex = publisherMap?['designationIndex'] as int?;
    final departmentIndex = publisherMap?['departmentIndex'] as int?;

    if (designationIndex != null && departmentIndex != null) {
      final designations = _cacheDesignations.value;
      final departments = _cacheDepartments.value;
      return Publisher(
        id: snapshot.key!,
        name: publisherMap?['name'] as String?,
        designation: designations?[designationIndex],
        department: departments?[departmentIndex],
        photoUrl: publisherMap?['photoUrl'] as String?,
      );
    }
    return null;
  }

  /// Convert database snapshot to model with logic specified.
  Future<Research?> snapshotToModel(DataSnapshot snapshot) async {
    final researchMap = snapshot.value?.toJson();
    final userId = researchMap?['userId'] as String?;
    final categoryIndex = researchMap?['categoryIndex'] as int?;

    if (userId != null && categoryIndex != null) {
      final publisher = await publisherById(userId);
      final categories = _cacheCategories.value;
      final researchJson = <String, Object?>{
        'id': snapshot.key,
        'publisher': publisher?.toJson(),
        ...?researchMap,
        'category': categories?[categoryIndex],
      };
      return Research.fromJson(researchJson);
    }
    return null;
  }

  Future<Research?> researchById(String id) async {
    final researches = await stream.first;
    for (final research in researches) {
      if (research.id == id) return research;
    }
    return null;
  }

  /// Emits list of research.
  Stream<List<Research>> get stream async* {
    if (_cache.value != null) yield _cache.value!;
    yield* _db.onValue.asyncMap<List<Research>>(
      (event) async {
        final researches = <Research>[];
        for (final snapshot in event.snapshot.children) {
          final research = await snapshotToModel(snapshot);
          if (research != null) researches.add(research);
        }
        return _cache.value = researches;
      },
    );
  }

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
  Future<(String?, Research)> read(String id) {
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

  @override
  Future<String?> delete(String id) async {
    try {
      await _db.child(id).remove();
    } catch (e, s) {
      log(_errorMsgDelete, error: e, stackTrace: s);
      return _errorMsgDelete;
    }
    return null;
  }
}
