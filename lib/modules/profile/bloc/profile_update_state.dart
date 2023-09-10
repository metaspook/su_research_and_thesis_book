part of 'profile_update_bloc.dart';

enum ProfileUpdateStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ProfileUpdateStatus.loading;
  bool get hasMessage =>
      this == ProfileUpdateStatus.success ||
      this == ProfileUpdateStatus.failure;
}

final class ProfileUpdateState extends Equatable {
  const ProfileUpdateState({
    this.status = ProfileUpdateStatus.initial,
    this.statusMsg = '',
    this.name = '',
    this.role = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.photoPath = '',
    this.obscurePassword = true,
    this.editMode = false,
  });

  final ProfileUpdateStatus status;
  final String statusMsg;
  final String name;
  final String role;
  final String email;
  final String password;
  final String phone;
  final String photoPath;
  final bool obscurePassword;
  final bool editMode;

  ProfileUpdateState copyWith({
    ProfileUpdateStatus? status,
    String? statusMsg,
    String? name,
    String? role,
    String? email,
    String? password,
    String? phone,
    String? photoPath,
    bool? obscurePassword,
    bool? editMode,
  }) {
    return ProfileUpdateState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      photoPath: photoPath ?? this.photoPath,
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
      photoPath,
      obscurePassword,
      editMode,
    ];
  }
}
