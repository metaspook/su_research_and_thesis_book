import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  group('CacheService', () {
    group('CacheService', () {
      test('can be instantiated', () {
        expect(Cache(), isNotNull);
      });
    });

    test('can write and read a value for a given key', () {
      final cache = Cache();
      const key = '__key__';
      const value = '__value__';
      expect(cache.read(key: key), isNull);
      cache.write(key: key, value: value);
      expect(cache.read(key: key), equals(value));
    });
  });
}
