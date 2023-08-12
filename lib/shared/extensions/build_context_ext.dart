import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

// Config
final _imageCropper = ImageCropper();

/// BuildContext Extensions.
extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  Widget? get backButton => Navigator.canPop(this)
      ? IconButton(
          onPressed: () {
            final currentFocus = FocusScope.of(this);
            currentFocus.hasPrimaryFocus == currentFocus.hasFocus
                ? Navigator.pop(this)
                : currentFocus.unfocus();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        )
      : null;

  Future<CroppedFile?> _cropImage(String sourcePath) => _imageCropper.cropImage(
        sourcePath: sourcePath,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: theme.colorScheme.inversePrimary,
            activeControlsWidgetColor: theme.colorScheme.inversePrimary,
          )
        ],
      );
  Future<String?> croppedImagePath(String sourcePath) async =>
      (await _cropImage(sourcePath))?.path;
  //- useful for web and Image.memory widget.
  Future<Uint8List?> croppedImageAsBytes(String sourcePath) async =>
      (await _cropImage(sourcePath))?.readAsBytes();
}
