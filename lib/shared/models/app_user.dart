// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// Named `AppUser` instead of `User` to prevent the same name conflict with firebase's `User` class.
class AppUser extends Equatable {
  const AppUser({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
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

  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;

  /// Empty user which represents an unauthenticated user.
  static const empty = AppUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AppUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AppUser.empty;

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
  List<Object?> get props {
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
