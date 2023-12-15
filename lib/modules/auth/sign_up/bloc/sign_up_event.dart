part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpEdited extends SignUpEvent {
  const SignUpEdited({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.designationIndex,
    this.departmentIndex,
  });

  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final int? designationIndex;
  final int? departmentIndex;

  @override
  List<Object?> get props =>
      [name, email, password, phone, designationIndex, departmentIndex];
}

final class SignUpPhotoPicked extends SignUpEvent {
  const SignUpPhotoPicked(this.photoPath, {this.statusMsg});

  final String? photoPath;
  final String? statusMsg;

  @override
  List<Object?> get props => [photoPath, statusMsg];
}

final class SignUpObscurePasswordToggled extends SignUpEvent {
  const SignUpObscurePasswordToggled();
}

final class SignUpProceeded extends SignUpEvent {
  const SignUpProceeded();
}
