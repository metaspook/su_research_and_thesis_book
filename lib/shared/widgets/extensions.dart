import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

// Config
final _imageCropper = ImageCropper();

/// Callable Widget Extensions.
extension CallableWidgetExt on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  Future<T?> showAlertDialog<T>() => showDialog<T>(
        context: this,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text('Thesis Entry', textAlign: TextAlign.center),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: AppThemes.outlineInputBorder,
                    label: Text('Thesis Name'),
                  ),
                ),
                SizedBox(height: 30),
                PdfViewer(
                  uri: 'https://css4.pub/2015/usenix/example.pdf',
                  heightPercent: .5,
                ),
              ],
            ),
          ),
        ),
      );

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

  // Image Cropper
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

/// PreferredSize Extensions.
extension PreferredSizeExt on Widget {
  /// Converts to a preferredSizeWidget. If size null, value fallback to Size.fromHeight(kToolbarHeight).
  PreferredSize toPreferredSize(Size? size) => PreferredSize(
        preferredSize: size ?? const Size.fromHeight(kToolbarHeight),
        child: this,
      );
}
