import 'package:flutter/foundation.dart';
// NOTE: Separate extensions as file per type in a folder if getting larger.

// Config
// <implement here, if any>

/// String Extensions.
extension StringExt on String {
  int toInt() => int.parse(this);
  double toDouble() => double.parse(this);
  String get first => this[0];
  String get last => this[length - 1];
  String get reversed => String.fromCharCodes(codeUnits.reversed);
  int get length => toString().length;
}

/// Number Extensions.
extension NumberExt on num {
  int get length => toString().length;
}

/// List Extensions
extension ListExt<T> on List<T> {
  List<T> get unique => [...toSet()];
}

/// Iterable Extensions
extension IterableExt<T> on Iterable<T> {
  Iterable<T> get unique => [...toSet()];
}

/// Object Extensions.
extension ObjectExt on Object {
  /// A list representation of this object.
  List<T> toList<T>({bool growable = true}) =>
      List<T>.from(this as List<Object?>, growable: growable);

  /// A map representation of this object.
  Map<K, V> toMap<K, V>() => Map<K, V>.from(this as Map<Object?, Object?>);

  /// A json map representation of this object.
  Map<String, Object?> toJson() => toMap<String, Object?>();
}

extension NotAvailableMethod on Null {
  String get notAvailable => 'N/A';
}

extension NullableObjectExt on Object? {
  /// A string representation of this object.
  /// * Parse `null` into 'N/A' (Not Available) or given value.
  /// * See also [toString] doc comment.
  String toStringParseNull([String value = 'N/A']) =>
      this == null ? value : toString();

  /// Extension representation of [print] method. Levels: 0	Success,
  /// 1 Warnings, 2 Errors, 3 Info (default).
  void doPrint([String prefix = '', int level = 3]) {
    if (kDebugMode) {
      final code = switch (level) { 0 => 36, 1 => 33, 2 => 31, _ => 32 };
      final text = '\x1B[${code}m$prefix${toString()}\x1B[0m';
      // ignore: avoid_print
      RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);

      // RegExp('.{1,800}')
      //     .allMatches(text)
      //     .map((m) => m.group(0))
      //     .forEach((element) {});
    }
  }

  // void mark([int level = 3]) {
  //   if (kDebugMode) {
  //     final code = switch (level) { 0 => 36, 1 => 33, 2 => 31, _ => 32 };
  //     final text = '\x1B[${code}mMark: ${toString()}\x1B[0m';
  //     // ignore: avoid_print
  //     RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);
  //   }
  // }

  /// Whether this object is null or empty String/Iterable/Map.
  // bool get isNullOrEmpty {
  //   final obj = this;
  //   if (obj is String) {
  //     return obj.isEmpty;
  //   } else if (obj is Iterable) {
  //     return obj.isEmpty;
  //   } else if (obj is Map) {
  //     return obj.isEmpty;
  //   }
  //   return obj == null;
  // }
}
