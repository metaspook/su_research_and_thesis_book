// Copyright 2023 MEtaspook. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:developer' show log;
import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart'
    show BuildContext, Image, Theme, ThemeData;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

export 'package:image_picker/image_picker.dart' show ImageSource;

// Config
final _imagePicker = ImagePicker();
final _imageCropper = ImageCropper();
// ignore: use_late_for_private_fields_and_variables
String? _statusMsg;

/// {@template image_cropicker}
/// Image Picker and Cropper.
/// {@endtemplate}
class ImageCropicker {
  /// {@macro image_cropicker}
  const ImageCropicker(BuildContext context) : _context = context;

  final BuildContext _context;

  ThemeData get _theme => Theme.of(_context);

  //-- Image Picker
  Future<XFile?> _pickImage(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(source: source);
      if (file != null) return file;
      _statusMsg = 'No image is picked!';
    } catch (e, s) {
      _statusMsg = "Couldn't pick the image";
      log("Couldn't pick the image", error: e, stackTrace: s);
    }
    return null;
  }

  //-- Image Cropper
  Future<CroppedFile?> _cropImage(String sourcePath) async {
    try {
      final file = await _imageCropper.cropImage(
        sourcePath: sourcePath,
        uiSettings: <PlatformUiSettings>[
          AndroidUiSettings(
            toolbarColor: _theme.colorScheme.inversePrimary,
            activeControlsWidgetColor: _theme.colorScheme.inversePrimary,
          ),
          IOSUiSettings(),
          WebUiSettings(context: _context),
        ],
      );
      if (file != null) return file;
      _statusMsg = 'No image is cropped!';
    } catch (e, s) {
      _statusMsg = "Couldn't crop the image";
      log("Couldn't crop the image", error: e, stackTrace: s);
    }
    return null;
  }

  //-- Public APIs
  /// Status message of picking, cropping and errors.
  /// * `null` value indicates successful operation.
  String? get statusMsg => _statusMsg;

  /// Pick image with crop option and get file.
  /// {@template null_indication}
  /// * Value `null`  indicates error or canceled operation, you can call
  /// [statusMsg] method in this case.
  /// {@endtemplate}
  Future<String?> path(ImageSource source, {bool crop = true}) async {
    final imagePath = (await _pickImage(source))?.path;
    if (crop && imagePath != null) return croppedPath(imagePath);
    return imagePath;
  }

  /// Pick image with crop option and get list of bytes,
  /// {@template useful_as_bytes}
  /// useful for web and [Image.memory] widget etc.
  /// {@endtemplate}
  /// {@macro null_indication}
  Future<Uint8List?> asBytes(
    ImageSource source, {
    bool crop = true,
  }) async {
    final image = await _pickImage(source);
    if (crop && image != null) return croppedAsBytes(image.path);
    return image?.readAsBytes();
  }

  /// Crop image and get file path.
  /// {@macro null_indication}
  Future<String?> croppedPath(String sourcePath) async =>
      (await _cropImage(sourcePath))?.path;

  /// Crop image and get list of bytes,
  /// {@macro useful_as_bytes}
  /// {@macro null_indication}
  Future<Uint8List?> croppedAsBytes(String sourcePath) async =>
      (await _cropImage(sourcePath))?.readAsBytes();
}
