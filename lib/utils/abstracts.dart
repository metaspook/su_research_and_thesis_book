import 'package:su_thesis_book/utils/utils.dart';

abstract class CrudAbstract {
  Future<String?> create(Json value);

  Future<String?> read(String id);

  Future<String?> update(Json value);

  Future<String?> delete(String id);
}
