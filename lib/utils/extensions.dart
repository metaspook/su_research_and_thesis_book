import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Configs
// const _isProduction = bool.fromEnvironment('IS_PRODUCTION');

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
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
