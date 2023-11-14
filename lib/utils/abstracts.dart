typedef _Json = Map<String, Object?>;

abstract class CrudAbstract<T> {
  Future<String?> create(String id, {required _Json value});

  Future<(String?, {T? object})> read(String id);

  Future<String?> update(String id, {required _Json value});

  Future<String?> delete(String id);
}
