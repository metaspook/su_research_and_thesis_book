import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photoUrl: json['photoUrl'] as String,
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

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
  }) {
    return User(
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
