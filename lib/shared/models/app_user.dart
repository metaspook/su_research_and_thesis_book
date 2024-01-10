import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

/// {@template user}
/// User model.
/// * Named `AppUser` instead of `User` to prevent the same name conflict with firebase's `User` class.
/// * [AppUser.empty] represents an unauthenticated user.
/// {@endtemplate}
final class AppUser extends Equatable {
  const AppUser({
    required this.id,
    this.name,
    this.designation,
    this.department,
    this.email,
    this.phone,
    this.photoUrl,
  });

  factory AppUser.fromJson(Json json) {
    return AppUser(
      id: json['id']! as String,
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      department: json['department'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  final String id;
  final String? designation;
  final String? department;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;

  /// Empty user which represents an unauthenticated user.
  static const unauthenticated = AppUser(id: '');
  bool get isAuthenticated => this != AppUser.unauthenticated;

  Map<String, dynamic> toJson() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'designation': designation,
      'department': designation,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        designation,
        department,
        email,
        phone,
        photoUrl,
      ];
}
