import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

//-- Config
const _uuid = Uuid();

List<T> dataSnapshotToList<T>(
  DataSnapshot dataSnapshot, {
  bool growable = true,
}) =>
    List<T>.from(dataSnapshot as List<Object?>, growable: growable);

Map<K, V> dataSnapshotToMap<K, V>(DataSnapshot dataSnapshot) =>
    Map<K, V>.from(dataSnapshot.value! as Map<Object?, Object?>);

// emits errorMsg
Future<({String? errorMsg, String? data})> fakeApi() async {
  // Range 2 to 5.
  final random = Random();
  final seconds = random.nextInt(3) + 2;
  final success = random.nextBool();
  const errorMsg = "Couldn't get the data!";
  const data = 'Demo String data.';
  return Future.delayed(
    Duration(seconds: seconds),
    () => success
        ? (errorMsg: null, data: data)
        : (errorMsg: errorMsg, data: null),
  );
}

/// Generates a unique id. `[RNG version 4 | random]`
String get uuid => _uuid.v4();

/// String representation of the current UTC date and time.
String get timestamp => DateTime.timestamp().toString();
