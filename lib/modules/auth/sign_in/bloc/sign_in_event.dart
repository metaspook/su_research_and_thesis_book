part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

final class SignInEdited extends SignInEvent {
  const SignInEdited({this.email, this.password});

  final String? email;
  final String? password;

  @override
  List<Object?> get props => [email, password];
}

final class SignInObscurePasswordToggled extends SignInEvent {
  const SignInObscurePasswordToggled();
}

final class SignInRememberMeToggled extends SignInEvent {
  const SignInRememberMeToggled();
}

final class SignInProceeded extends SignInEvent {
  const SignInProceeded();
}
