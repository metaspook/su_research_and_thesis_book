import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

// defined outside to make repo const (experimental).
final _filePicker = FilePicker.platform;
late String? _errorMsg;
// ignore: use_late_for_private_fields_and_variables
String? _filePath;

class ThesisRepo {
  const ThesisRepo();

  Future<FilePickerResult?> _pickPdf() async {
    if (_filePath != null) await _filePicker.clearTemporaryFiles();
    final result = await _filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) _errorMsg = "Couldn't pick the pdf file";
    return result;
  }

  // Public APIs
  String? get errorMsg => _errorMsg;

  Future<bool?> clearTempFiles() => _filePicker.clearTemporaryFiles();

  Future<String?> pickedPdfPath() async =>
      _filePath = (await _pickPdf())?.files.single.path;

  //- useful for web and Image.memory widget.
  Future<Uint8List?> pickedPdfAsBytes() async =>
      (await _pickPdf())?.files.single.bytes;
}
