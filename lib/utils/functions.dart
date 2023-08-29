import 'package:firebase_database/firebase_database.dart';

List<T> dataSnapshotToList<T>(
  DataSnapshot dataSnapshot, {
  bool growable = true,
}) =>
    List<T>.from(dataSnapshot as List<Object?>, growable: growable);

Map<K, V> dataSnapshotToMap<K, V>(DataSnapshot dataSnapshot) =>
    Map<K, V>.from(dataSnapshot.value! as Map<Object?, Object?>);
