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
    this.role,
  });

  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? role;

  @override
  List<Object?> get props => [name, email, password, phone, role];
}

final class SignUpPhotoPicked extends SignUpEvent {
  const SignUpPhotoPicked(this.photoPath, {this.statusMsg});

  final String? photoPath;
  final String? statusMsg;
}

final class SignUpFormLoaded extends SignUpEvent {
  const SignUpFormLoaded();
}

final class SignUpProceeded extends SignUpEvent {
  const SignUpProceeded();
}
