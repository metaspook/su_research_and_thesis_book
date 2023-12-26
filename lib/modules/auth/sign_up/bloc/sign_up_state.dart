part of 'sign_up_bloc.dart';

enum SignUpStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == SignUpStatus.loading;
}

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.statusMsg,
    this.name = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.departments,
    this.designations,
    this.designationIndex = 0,
    this.departmentIndex = 0,
    this.photoPath = '',
    this.obscurePassword = true,
  });

  final SignUpStatus status;
  final String? statusMsg;
  final String name;
  final String email;
  final String password;
  final String phone;
  final List<String>? departments;
  final List<String>? designations;
  final int designationIndex;
  final int departmentIndex;
  final String photoPath;
  final bool obscurePassword;
  // bool get hasMessage => statusMsg != null;

  SignUpState copyWith({
    SignUpStatus? status,
    String? statusMsg,
    String? name,
    String? email,
    String? password,
    String? phone,
    List<String>? departments,
    List<String>? designations,
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
      departments: departments ?? this.departments,
      designations: designations ?? this.designations,
      designationIndex: designationIndex ?? this.designationIndex,
      departmentIndex: departmentIndex ?? this.departmentIndex,
      photoPath: photoPath ?? this.photoPath,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      name,
      email,
      password,
      phone,
      departments,
      designations,
      designationIndex,
      departmentIndex,
      photoPath,
      obscurePassword,
    ];
  }
}
