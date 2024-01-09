part of 'sign_in_bloc.dart';

enum SignInStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == SignInStatus.loading;
}

final class SignInState extends Equatable {
  const SignInState({
    this.status = SignInStatus.initial,
    this.statusMsg,
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.rememberMe = false,
  });

  final SignInStatus status;
  final String? statusMsg;
  final String email;
  final String password;
  final bool obscurePassword;
  final bool rememberMe;

  SignInState copyWith({
    SignInStatus? status,
    String? statusMsg,
    String? email,
    String? password,
    bool? obscurePassword,
    bool? rememberMe,
  }) {
    return SignInState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props {
    return [status, statusMsg, email, password, obscurePassword, rememberMe];
  }
}
