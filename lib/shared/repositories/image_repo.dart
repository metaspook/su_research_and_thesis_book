import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// defined outside to make repo const (experimental).
final _imagePicker = ImagePicker();
final _imageCropper = ImageCropper();
late String? _errorMsg;

class ImageRepo {
  const ImageRepo();

  Future<XFile?> _pickImage(ImageSource source) async {
    final file = await _imagePicker.pickImage(source: source);
    if (file != null) _errorMsg = "Couldn't pick the image";
    return file;
  }

  Future<CroppedFile?> _cropImage(String sourcePath) async {
    final file = await _imageCropper.cropImage(sourcePath: sourcePath);
    if (file != null) _errorMsg = "Couldn't crop the image";
    return file;
  }

  // Public APIs
  String? get errorMsg => _errorMsg;

  Future<String?> get cameraImagePath async =>
      (await _pickImage(ImageSource.camera))?.path;

  Future<String?> get galleryImagePath async =>
      (await _pickImage(ImageSource.gallery))?.path;

  Future<String?> cropImagePath(String sourcePath) async =>
      (await _cropImage(sourcePath))?.path;

  //- useful for web
  Future<Uint8List?> get cameraImageAsBytes async =>
      (await _pickImage(ImageSource.camera))?.readAsBytes();

  Future<Uint8List?> get galleryImageAsBytes async =>
      (await _pickImage(ImageSource.gallery))?.readAsBytes();

  Future<Uint8List?> cropImageAsBytes(String sourcePath) async =>
      (await _cropImage(sourcePath))?.readAsBytes();
}
