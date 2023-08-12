import 'package:flutter/material.dart';

/// Widget Extensions.
extension WidgetExt on Widget {
  /// Converts to a preferredSizeWidget. If size null, value fallback to Size.fromHeight(kToolbarHeight).
  PreferredSize toPreferredSize(Size? size) => PreferredSize(
        preferredSize: size ?? const Size.fromHeight(kToolbarHeight),
        child: this,
      );
}
