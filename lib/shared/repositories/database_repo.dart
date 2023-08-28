import 'package:firebase_database/firebase_database.dart';

final _firebaseDatabase = FirebaseDatabase.instance
  ..setPersistenceEnabled(true);

abstract class DatabaseRepo {
  const DatabaseRepo();
  DatabaseReference get db => _firebaseDatabase.ref(dbPath);
  String get dbPath;

  Future<bool> create(Map<String, Object?> value);
  Future<bool> read(String id);
  Future<bool> update(Map<String, Object?> value);
  Future<bool> delete(String id);
}
