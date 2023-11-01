/// A minimalistic in-memory caching service.
sealed class CacheService {
  // const CacheService();
  static final _global = <String, Object>{};

  /// Provides global cache accessibility.
  static Map<String, Object?> global() => _global;

  // T? read<T extends Object>(String key) => _global[key]! as T;
  // T write<T extends Object>(String key, T value) => _global[key] = value;

  /// Provides local cache accessibility.
  /// * Value type will be `Object?` if not specify in place of `T`.
  /// * Value type will be `Object` if not specify in place of `T`.
  // static Map<String, T> local<T extends Object>() => <String, T>{};
  static Map<String, T> local<T extends Object?>() => <String, T>{};
}
