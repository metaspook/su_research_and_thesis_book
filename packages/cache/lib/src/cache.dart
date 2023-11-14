// Copyright (c) 2023, Metaspook.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

typedef _Json = Map<String, Object?>;

/// {@template intro}
/// A minimalistic in-memory caching service.
/// {@endtemplate}
class Cache<T extends Object> {
  /// {@macro intro}
  /// * Provides a node of global cache hive.
  /// * Value type will be `Object` if not specify in place of `T`.
  /// * Example of a cache instance with key name and value type:
  /// ```dart
  /// const Cache<List<String>>('names')
  /// ```
  const Cache(String key) : _key = key;
  final String _key;
  static _Json? _cacheHive;
  _Json get _hive => _cacheHive ??= {};

  /// Whether this node contains the given [value].
  bool contains(T? value) => _hive.containsValue(value);

  /// Returns the [value] then remove with its key.
  T? remove() => _hive.remove(_key) as T?;

  /// Reset the global cache hive to null state.
  static void reset() => _cacheHive = null;

  /// Get or Set the value of cache and passthrough.
  T? get value => _hive[_key] as T?;
  set value(T? object) => _hive[_key] = object;

  /// Whether the value is null or empty.
  bool get isNullOrEmpty {
    final object = value;
    if (object is String) {
      return object.isEmpty;
    } else if (object is Iterable) {
      return object.isEmpty;
    } else if (object is Map) {
      return object.isEmpty;
    }
    return object == null;
  }
}
