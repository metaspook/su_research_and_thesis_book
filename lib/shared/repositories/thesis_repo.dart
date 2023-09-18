import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

// export 'package:su_thesis_book/utils/utils.dart' show uuid;

class ThesisRepo implements CrudAbstract<Thesis> {
  const ThesisRepo();

  //-- Config
  static final _filePicker = FilePicker.platform;
  static final _db = FirebaseDatabase.instance.ref('theses');
  static final _storage = FirebaseStorage.instance.ref('theses');
  static const _errorMsgCreateThesis = "Couldn't create the Thesis!";
  static const _errorMsgReadThesis = "Couldn't read the Thesis data!";
  static const _errorMsgUpdateThesis = "Couldn't update the Thesis!";
  static const _errorMsgDeleteThesis = "Couldn't delete the Thesis!";
  static const _errorMsgUploadFile = "Couldn't upload the thesis file!";
  static const _errorMsgFilePicker = "Couldn't pick the file!";
  static const _errorMsgTempFiles = "Couldn't clear the temporary file!";

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
  Stream<List<Thesis>> get thesesStream => _db.onValue.map<List<Thesis>>(
        (event) => event.snapshot.value == null
            ? const []
            : [
                for (final e in event.snapshot.children)
                  Thesis.fromJson({
                    'id': e.key,
                    ...e.value!.toJson(),
                  }),
              ],
      );

  // Stream<List<Thesis>> get thesisStream => _db.onValue.map<List<Thesis>>(
  //       (event) => event.snapshot.value == null
  //           ? const []
  //           : [for (final e in event.snapshot.value!)] Thesis.fromJson(event.snapshot.value!.toJson()),
  //     );

  /// Upload thesis file to Storage and get URL.
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
  Future<String?> create(String thesisId, {required Json value}) async {
    try {
      await _db.child(thesisId).set(value);
    } catch (e, s) {
      log(_errorMsgCreateThesis, error: e, stackTrace: s);
      return _errorMsgCreateThesis;
    }
    return null;
  }

  @override
  Future<String?> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(String?, {Thesis? object})> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<String?> update(String id, {required Json value}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
