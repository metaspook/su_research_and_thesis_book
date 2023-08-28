part of 'profile_cubit.dart';

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
    this.croppedImagePath = '',
    this.pickedImagePath = '',
  });

  final ProfileStatus status;
  final String statusMsg;
  final String name;
  final String role;
  final String email;
  final String password;
  final String phone;
  final String croppedImagePath;
  final String pickedImagePath;

  ProfileState copyWith({
    ProfileStatus? status,
    String? statusMsg,
    String? name,
    String? role,
    String? email,
    String? password,
    String? phone,
    String? croppedImagePath,
    String? pickedImagePath,
  }) {
    return ProfileState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      croppedImagePath: croppedImagePath ?? this.croppedImagePath,
      pickedImagePath: pickedImagePath ?? this.pickedImagePath,
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
      croppedImagePath,
      pickedImagePath,
    ];
  }
}
