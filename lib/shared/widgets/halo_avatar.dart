// import 'package:beezness/utils/utils.dart';
// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Returns a new color that matches this color with the alpha channel
/// replaced with the given `size` (which ranges from 0.0 to 1.0).
///
/// Out of range values will have unexpected effects.

/// Creates a circle with halo that represents a user.
class HaloAvatar extends StatelessWidget {
  const HaloAvatar({
    super.key,
    this.imagePath,
    this.size = .825,
    this.haloColor,
    this.errorColor,
  });

  /// The radius of the avatar is multiplication between `size` and `kToolbarHeight`.
  final double size;
  final Color? haloColor;
  final Color? errorColor;
  final String? imagePath;

  static late Color _haloColor;
  static final _memoryImage = MemoryImage(base64Decode(_placeholderImage));
  static const _placeholderImage =
      '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';

  //  SizeBox
  //  height: _size * .965,
  //  width: _size * .965,

  @override
  Widget build(BuildContext context) {
    _haloColor = haloColor ?? Theme.of(context).colorScheme.primary;
    return Center(
      child: imagePath == null
          ? _imageBuilder(context, _memoryImage)
          : CachedNetworkImage(
              imageUrl: imagePath!,
              imageBuilder: _imageBuilder,
              // fit: BoxFit.scaleDown,
              progressIndicatorBuilder: _progressIndicatorBuilder,
              errorWidget: _errorWidget,
            ),
    );
  }

  double get _radius {
    // assert(size >= 0.0 && size <= 1.0, "'size' value out of range!");
    return kToolbarHeight * size;
  }

  double get _haloWidth => _radius * .035;

  Widget _progressIndicatorBuilder(
    BuildContext context,
    String url,
    DownloadProgress progress,
  ) =>
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: _radius,
            width: _radius,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              image: DecorationImage(
                image: _memoryImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: _radius * .965,
            width: _radius * .965,
            child: CircularProgressIndicator(
              strokeWidth: _haloWidth,
              color: _haloColor,
            ),
          ),
        ],
      );

  Widget _errorWidget(BuildContext context, String url, dynamic error) =>
      Icon(Icons.error, color: errorColor);

  Widget _imageBuilder(
    BuildContext context,
    ImageProvider<Object> imageProvider,
  ) =>
      Container(
        height: _radius,
        width: _radius,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(color: _haloColor, width: _haloWidth),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
}
