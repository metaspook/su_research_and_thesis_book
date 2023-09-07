part of 'profile_bloc.dart';

enum ProfileStatus { initial, editing, loading, success, failure }

final class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.statusMsg = '',
    this.name = '',
    this.role = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.photoUrl = '',
    this.obscurePassword = true,
    this.editMode = false,
  });

  final ProfileStatus status;
  final String statusMsg;
  final String name;
  final String role;
  final String email;
  final String password;
  final String phone;
  final String photoUrl;
  final bool obscurePassword;
  final bool editMode;

  ProfileState copyWith({
    ProfileStatus? status,
    String? statusMsg,
    String? name,
    String? role,
    String? email,
    String? password,
    String? phone,
    String? photoUrl,
    bool? obscurePassword,
    bool? editMode,
  }) {
    return ProfileState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      editMode: editMode ?? this.editMode,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      statusMsg,
      name,
      role,
      email,
      password,
      phone,
      photoUrl,
      obscurePassword,
      editMode,
    ];
  }
}
