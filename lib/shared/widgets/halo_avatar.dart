// import 'package:beezness/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';

/// Returns a new color that matches this color with the alpha channel
/// replaced with the given `size` (which ranges from 0.0 to 1.0).
///
/// Out of range values will have unexpected effects.
class HaloAvatar extends StatelessWidget {
  const HaloAvatar({
    super.key,
    this.imagePath,
    this.size = .825,
    this.haloAccent = const Color(0xFF000000),
    this.errorColor,
  });

  final String? imagePath;
  final double size;
  final Color haloAccent;
  final Color? errorColor;

  @override
  Widget build(BuildContext context) {
    return imagePath == null
        ? _imageContainer(
            context,
            const $AssetsImagesGen().placeholderUser01.provider(),
          )
        : CachedNetworkImage(
            imageUrl: imagePath!,
            imageBuilder: _imageContainer,
            placeholder: (context, url) => CircularProgressIndicator(
              strokeWidth: _haloWidth,
              color: haloAccent.withOpacity(.75),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: errorColor,
            ),
          );
  }

  double get _size {
    assert(size >= 0.0 && size <= 1.0, "'size' value out of range!");
    return kToolbarHeight * size;
  }

  double get _haloWidth => _size * .035;

  Widget _imageContainer(BuildContext context, ImageProvider imageProvider) =>
      Container(
        height: _size,
        width: _size,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              color: haloAccent,
              width: _haloWidth,
            ),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
}
