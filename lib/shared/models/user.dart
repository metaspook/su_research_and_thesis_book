import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.username});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
    );
  }

  final String id;
  final String username;

  @override
  List<Object> get props => [id, username];

  User copyWith({
    String? id,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
    };
  }

  @override
  bool get stringify => true;
}
