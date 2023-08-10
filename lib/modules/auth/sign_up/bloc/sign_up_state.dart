part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, editing, loading, success, failure }

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.statusMsg = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.imagePath,
  });

  final SignUpStatus status;
  final String statusMsg;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? imagePath;

  SignUpState copyWith({
    SignUpStatus? status,
    String? statusMsg,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? imagePath,
  }) {
    return SignUpState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props {
    return [status, statusMsg, name, email, password, phone, imagePath];
  }
}
