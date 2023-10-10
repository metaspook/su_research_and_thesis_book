part of 'password_bloc.dart';

sealed class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object?> get props => [];
}

final class PasswordEdited extends PasswordEvent {
  const PasswordEdited({this.email, this.password});

  final String? email;
  final String? password;

  @override
  List<Object?> get props => [email, password];
}

final class PasswordObscurePasswordToggled extends PasswordEvent {
  const PasswordObscurePasswordToggled();
}

final class PasswordRememberMeToggled extends PasswordEvent {
  const PasswordRememberMeToggled();
}

final class PasswordProceeded extends PasswordEvent {
  const PasswordProceeded();
}
