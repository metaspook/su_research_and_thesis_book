// Copyright (c) 2023, Metaspook.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

/// A minimalistic in-memory caching service.
class Cache<T extends Object> {
  /// Provides a node of global cache hive.
  /// {@template specify_type}
  /// * Value type will be `Object` if not specify in place of `T`.
  /// {@endtemplate}
  const Cache(String key)
      : _key = key,
        _isGlobal = true,
        _local = null;

  /// Provides a node of local cache hive.
  /// {@macro specify_type}
  Cache.local(String key)
      : _key = key,
        _isGlobal = false,
        _local = <String, Object>{};

  final String _key;
  final bool _isGlobal;
  final Json? _local;
  static Json? _global;
  Json get _hive => _isGlobal ? _global ??= <String, Object?>{} : _local!;

  /// Returns value containing status as bool.
  bool contains(T value) => _hive.containsValue(value);

  /// Returns the value and removes with its key.
  T? remove(T value) => _hive.remove(_key) as T?;

  /// Removes all entries from the cache hive.
  void clear() => _hive.clear();

  /// Reset the global cache hive to null state.
  static void dispose() => _global = null;

  /// * Get or Set the value of cache and passthrough.
  T? get value => _hive[_key] as T?;
  set value(T? object) => _hive[_key] = object;

  // /// Whether the value is null.
  // bool get isNull => value == null;

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

typedef Json = Map<String, Object?>;

// extension IsNullOrEmptyString<T> on String? {
//   bool get isNullOrEmpty => this == null || this!.isEmpty;
// }

// extension IsNullOrEmptyIterable<E> on Iterable<E>? {
//   bool get isNullOrEmpty => this == null || this!.isEmpty;
// }

// extension IsNullOrEmptyMap<K, V> on Map<K, V>? {
//   bool get isNullOrEmpty => this == null || this!.isEmpty;
// }

// extension IsNullExt on Object? {
//   bool get isNull => this == null;
// }
