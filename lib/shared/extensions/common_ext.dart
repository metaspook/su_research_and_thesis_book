import 'package:flutter/foundation.dart';

// NOTE: Separate extensions in files if getting larger.

/// String Extensions.
extension StringExt on String {
  int toInt() => int.parse(this);
  double toDouble() => double.parse(this);
  String get first => this[0];
  String get last => this[length - 1];
  String get reversed => String.fromCharCodes(codeUnits.reversed);
}

/// Number Extensions.
extension NumberExt on num {
  int get length => toString().length;
}

/// Object Extensions.
extension PrintMethod on Object? {
  /// Extension representation of [print] method. Levels: 0	Success,
  /// 1 Warnings, 2 Errors, 3 Info (default).
  void doPrint([int level = 3]) {
    if (kDebugMode) {
      final code = switch (level) { 0 => 36, 1 => 33, 2 => 31, _ => 32 };
      final text = '\x1B[${code}m${toString()}\x1B[0m';
      // ignore: avoid_print
      RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);

      // RegExp('.{1,800}')
      //     .allMatches(text)
      //     .map((m) => m.group(0))
      //     .forEach((element) {});
    }
  }
}
