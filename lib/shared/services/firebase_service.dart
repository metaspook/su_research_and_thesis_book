import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _auth = FirebaseAuth.instance;
final _db = FirebaseDatabase.instance..setPersistenceEnabled(true);
final _storage = FirebaseStorage.instance;

class FirebaseService {
  const FirebaseService();

  FirebaseAuth get auth => _auth;
  FirebaseDatabase get db => _db;
  FirebaseStorage get storage => _storage;
}
