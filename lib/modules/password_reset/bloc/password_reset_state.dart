part of 'password_reset_bloc.dart';

enum PasswordResetStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == PasswordResetStatus.loading;
  bool get hasMessage =>
      this == PasswordResetStatus.success ||
      this == PasswordResetStatus.failure;
}

final class PasswordResetState extends Equatable {
  const PasswordResetState({
    this.status = PasswordResetStatus.initial,
    this.statusMsg = '',
    this.email = '',
    this.currentPassword = '',
    this.newPassword = '',
    this.obscureCurrentPassword = true,
    this.obscureNewPassword = true,
  });

  final PasswordResetStatus status;
  final String statusMsg;
  final String email;
  final String currentPassword;
  final String newPassword;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;

  PasswordResetState copyWith({
    PasswordResetStatus? status,
    String? statusMsg,
    String? email,
    String? currentPassword,
    String? newPassword,
    bool? obscureCurrentPassword,
    bool? obscureNewPassword,
  }) {
    return PasswordResetState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      email: email ?? this.email,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      obscureCurrentPassword:
          obscureCurrentPassword ?? this.obscureCurrentPassword,
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      statusMsg,
      email,
      currentPassword,
      newPassword,
      obscureCurrentPassword,
      obscureNewPassword,
    ];
  }
}
