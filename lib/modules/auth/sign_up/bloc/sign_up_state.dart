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
    this.croppedImagePath = '',
    this.pickedImagePath = '',
  });

  final SignUpStatus status;
  final String statusMsg;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String croppedImagePath;
  final String pickedImagePath;

  SignUpState copyWith({
    SignUpStatus? status,
    String? statusMsg,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? croppedImagePath,
    String? pickedImagePath,
  }) {
    return SignUpState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      name: name ?? this.name,
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
      email,
      password,
      phone,
      croppedImagePath,
      pickedImagePath,
    ];
  }
}
