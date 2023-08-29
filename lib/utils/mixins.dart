import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseStorage = FirebaseStorage.instance;
final _firebaseDatabase = FirebaseDatabase.instance
  ..setPersistenceEnabled(true);

mixin FirebaseMixin {
  FirebaseAuth get auth => _firebaseAuth;
  Reference get storage => _firebaseStorage.ref(storagePath);
  DatabaseReference get db => _firebaseDatabase.ref(dbPath);
  DatabaseReference get rolesRef => _firebaseDatabase.ref('roles');
  String get dbPath;
  String get storagePath;
}
