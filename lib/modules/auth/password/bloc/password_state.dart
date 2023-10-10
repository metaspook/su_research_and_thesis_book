part of 'password_bloc.dart';

enum PasswordStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == PasswordStatus.loading;
  bool get hasMessage =>
      this == PasswordStatus.success || this == PasswordStatus.failure;
}

final class PasswordState extends Equatable {
  const PasswordState({
    this.status = PasswordStatus.initial,
    this.statusMsg = '',
    this.password = '',
    this.obscurePassword = true,
  });

  final PasswordStatus status;
  final String statusMsg;
  final String password;
  final bool obscurePassword;

  PasswordState copyWith({
    PasswordStatus? status,
    String? statusMsg,
    String? password,
    bool? obscurePassword,
  }) {
    return PasswordState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object> get props {
    return [status, statusMsg, password, obscurePassword];
  }
}
