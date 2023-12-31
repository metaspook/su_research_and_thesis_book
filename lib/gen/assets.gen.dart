/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/launcher_icon.png
  AssetGenImage get launcherIcon =>
      const AssetGenImage('assets/images/launcher_icon.png');

  /// File path: assets/images/launcher_icon_background.png
  AssetGenImage get launcherIconBackground =>
      const AssetGenImage('assets/images/launcher_icon_background.png');

  /// File path: assets/images/launcher_icon_foreground.png
  AssetGenImage get launcherIconForeground =>
      const AssetGenImage('assets/images/launcher_icon_foreground.png');

  /// File path: assets/images/logo_01_transparent.svg
  String get logo01Transparent => 'assets/images/logo_01_transparent.svg';

  /// File path: assets/images/placeholder_user_01.jpg
  AssetGenImage get placeholderUser01 =>
      const AssetGenImage('assets/images/placeholder_user_01.jpg');

  /// File path: assets/images/placeholder_user_01_dark.jpg
  AssetGenImage get placeholderUser01Dark =>
      const AssetGenImage('assets/images/placeholder_user_01_dark.jpg');

  /// File path: assets/images/placeholder_user_01_dark_glow.jpg
  AssetGenImage get placeholderUser01DarkGlow =>
      const AssetGenImage('assets/images/placeholder_user_01_dark_glow.jpg');

  /// File path: assets/images/placeholder_user_01_invert.jpg
  AssetGenImage get placeholderUser01Invert =>
      const AssetGenImage('assets/images/placeholder_user_01_invert.jpg');

  /// File path: assets/images/signin_banner_01.svg
  String get signinBanner01 => 'assets/images/signin_banner_01.svg';

  /// List of all assets
  List<dynamic> get values => [
        launcherIcon,
        launcherIconBackground,
        launcherIconForeground,
        logo01Transparent,
        placeholderUser01,
        placeholderUser01Dark,
        placeholderUser01DarkGlow,
        placeholderUser01Invert,
        signinBanner01
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
