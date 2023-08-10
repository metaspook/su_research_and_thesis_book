import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageRepo {
  ImageRepo();

  final _imagePicker = ImagePicker();

  Future<XFile?> _pickImage(ImageSource source) async {
    final file = await _imagePicker.pickImage(source: source);
    if (file != null) errorMsg = "Couldn't pick the image";
    return file;
  }

  // Public APIs
  String? errorMsg;

  Future<String?> get cameraImagePath async =>
      (await _pickImage(ImageSource.camera))?.path;

  Future<String?> get galleryImagePath async =>
      (await _pickImage(ImageSource.gallery))?.path;

  //- useful for web
  Future<Uint8List?> get cameraImageAsBytes async =>
      (await _pickImage(ImageSource.camera))?.readAsBytes();

  Future<Uint8List?> get galleryImageAsBytes async =>
      (await _pickImage(ImageSource.gallery))?.readAsBytes();
}
