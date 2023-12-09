import 'package:su_thesis_book/utils/utils.dart';

/// CRUD operations abstract to implement on repository.
abstract class CRUD<T> {
  /// Creates data.
  /// {@template CRUD}
  /// * Returns Error message as `String?` and `null` indicates success.
  /// {@endtemplate}
  Future<String?> create(String id, {required Json value});

  /// Reads data (returns as record).
  /// {@macro CRUD}
  /// * Returns data as `Object` or type annotated in place of `T` of the class.
  Future<(String?, T)> read(String id);

  /// Updates data.
  /// {@macro CRUD}
  Future<String?> update(String id, {required Json value});

  /// Deletes data.
  /// {@macro CRUD}
  Future<String?> delete(String id);
}


  /// {@template CU}
  /// * Value as `Object` or type annotated in place of `T` of the method.
  /// {@endtemplate}
