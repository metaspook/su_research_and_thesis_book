// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// Named `AppUser` instead of `User` to prevent the same name conflict with firebase's `User` class.
class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }

  factory AppUser.fromFirebaseObj(
    Object obj, {
    required String id,
  }) {
    final objMap = Map<String, dynamic>.from(
      obj as Map<Object?, Object?>,
    );
    return AppUser(
      id: id,
      name: objMap['name'] as String,
      email: objMap['email'] as String,
      phone: objMap['phone'] as String,
      photoUrl: objMap['photoUrl'] as String,
    );
  }

  // User? fromFirebase(fb.User? firebaseUser) {
  //   if (firebaseUser == null) return null;
  //   return User(
  //     id: firebaseUser.uid,
  //     name: json['name'] as String,
  //     email: json['email'] as String,
  //     phone: json['phone'] as String,
  //     photoUrl: json['photoUrl'] as String,
  //   );
  // }

  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }

  Map<String, dynamic> toFirebaseObj() {
    return <String, dynamic>{
      id: {
        'name': name,
        'email': email,
        'phone': phone,
        'photoUrl': photoUrl,
      },
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone,
      photoUrl,
    ];
  }

  @override
  bool get stringify => true;
}
