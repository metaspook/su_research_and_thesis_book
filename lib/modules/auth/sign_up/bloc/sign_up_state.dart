part of 'sign_up_bloc.dart';

enum SignUpStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == SignUpStatus.loading;
  bool get hasMessage =>
      this == SignUpStatus.success || this == SignUpStatus.failure;
}

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.statusMsg = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.designationIndex = 0,
    this.departmentIndex = 0,
    this.photoPath = '',
    this.obscurePassword = true,
  });

  final SignUpStatus status;
  final String statusMsg;
  final String name;
  final String email;
  final String password;
  final String phone;
  final int designationIndex;
  final int departmentIndex;
  final String photoPath;
  final bool obscurePassword;

  SignUpState copyWith({
    SignUpStatus? status,
    String? statusMsg,
    String? name,
    String? email,
    String? password,
    String? phone,
    int? designationIndex,
    int? departmentIndex,
    String? photoPath,
    bool? obscurePassword,
  }) {
    return SignUpState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      designationIndex: designationIndex ?? this.designationIndex,
      departmentIndex: departmentIndex ?? this.departmentIndex,
      photoPath: photoPath ?? this.photoPath,
      obscurePassword: obscurePassword ?? this.obscurePassword,
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
      designationIndex,
      departmentIndex,
      photoPath,
      obscurePassword,
    ];
  }
}
