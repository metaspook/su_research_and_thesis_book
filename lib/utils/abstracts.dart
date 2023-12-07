import 'package:su_thesis_book/utils/utils.dart';

/// Abstract to implement on repository for CRUD operations.
/// * First returning `String?` is for error message, `null` indicates success.
/// * Method [read] returns record with `object` parameter as type annotated
/// in place of `T`.
abstract class CRUD<T> {
  Future<String?> create(String id, {required Json value});

  Future<(String?, {T? object})> read(String id);

  Future<String?> update(String id, {required Json value});

  Future<String?> delete(String id);
}
