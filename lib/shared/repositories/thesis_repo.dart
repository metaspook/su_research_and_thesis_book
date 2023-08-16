import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

// defined outside to make repo const (experimental).
final _filePicker = FilePicker.platform;
late String? _errorMsg;

class ThesisRepo {
  const ThesisRepo();

  Future<FilePickerResult?> _pickPdf() async {
    final result = await _filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) _errorMsg = "Couldn't pick the pdf file";
    return result;
  }

  // Public APIs
  String? get errorMsg => _errorMsg;

  Future<String?> pickedPdfPath() async =>
      (await _pickPdf())?.files.single.path;

  //- useful for web and Image.memory widget.
  Future<Uint8List?> pickedPdfAsBytes() async =>
      (await _pickPdf())?.files.single.bytes;
}
