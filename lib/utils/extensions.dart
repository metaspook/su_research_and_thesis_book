import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Configs
// const _isProduction = bool.fromEnvironment('IS_PRODUCTION');

/// BuildContext Extensions.
extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

/// Widget Extensions.
extension WidgetExt on Widget {
  /// Converts to a preferredSizeWidget. If size null, value fallback to Size.fromHeight(kToolbarHeight).
  PreferredSize toPreferredSize(Size? size) => PreferredSize(
        preferredSize: size ?? const Size.fromHeight(kToolbarHeight),
        child: this,
      );
}

/// String Extensions.
extension StringExt on String {
  int toInt() => int.parse(this);
  double toDouble() => double.parse(this);
}

/// Number Extensions.
extension NumberExt on num {
  int get length => toString().length;
}

extension PrintExtensions on Object? {
  /// Extension representation of [print] method. Levels: 0	Success,
  /// 1 Warnings, 2 Errors, 3 Info (default).
  void doPrint([int level = 3]) {
    if (kDebugMode) {
      final code = switch (level) { 0 => 36, 1 => 33, 2 => 31, _ => 32 };
      print('\x1B[${code}m${toString()}\x1B[0m');
    }
  }
}
