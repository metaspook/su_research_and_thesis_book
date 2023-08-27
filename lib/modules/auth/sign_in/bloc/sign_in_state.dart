part of 'sign_in_bloc.dart';

enum SignInStatus { initial, editing, loading, success, failure }

final class SignInState extends Equatable {
  const SignInState({
    this.status = SignInStatus.initial,
    this.statusMsg = '',
    this.email = '',
    this.password = '',
  });

  final SignInStatus status;
  final String statusMsg;

  final String email;
  final String password;

  SignInState copyWith({
    SignInStatus? status,
    String? statusMsg,
    String? email,
    String? password,
  }) {
    return SignInState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      statusMsg,
      email,
      password,
    ];
  }
}
