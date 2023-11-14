import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  group('Cache', () {
    test('can be instantiated', () {
      expect(const Cache<String>('__key__'), isNotNull);
    });

    test('can write and read a value for a given key', () {
      const cache = Cache<String>('__key__');
      const newValue = '__value__';
      expect(cache.value, isNull);
      cache.value = newValue;
      expect(cache.value, equals(newValue));
    });
  });
}
