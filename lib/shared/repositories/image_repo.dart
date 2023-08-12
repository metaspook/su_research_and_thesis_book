import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

export 'package:image_picker/image_picker.dart' show ImageSource;

// defined outside to make repo const (experimental).
final _imagePicker = ImagePicker();
late String? _errorMsg;

class ImageRepo {
  const ImageRepo();

  Future<XFile?> _pickImage(ImageSource source) async {
    final file = await _imagePicker.pickImage(source: source);
    if (file != null) _errorMsg = "Couldn't pick the image";
    return file;
  }

  // Public APIs
  String? get errorMsg => _errorMsg;

  Future<String?> pickedImagePath(ImageSource source) async =>
      (await _pickImage(source))?.path;

  //- useful for web and Image.memory widget.
  Future<Uint8List?> pickedImageAsBytes(ImageSource source) async =>
      (await _pickImage(source))?.readAsBytes();
}
