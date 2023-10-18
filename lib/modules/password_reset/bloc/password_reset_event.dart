part of 'password_reset_bloc.dart';

sealed class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object?> get props => [];
}

final class PasswordResetEdited extends PasswordResetEvent {
  const PasswordResetEdited({
    this.email,
    this.currentPassword,
    this.newPassword,
  });

  final String? email;
  final String? currentPassword;
  final String? newPassword;

  @override
  List<Object?> get props => [email, currentPassword, newPassword];
}

final class PasswordResetObscureCurrentPasswordToggled
    extends PasswordResetEvent {
  const PasswordResetObscureCurrentPasswordToggled();
}

final class PasswordResetObscureNewPasswordToggled extends PasswordResetEvent {
  const PasswordResetObscureNewPasswordToggled();
}

final class PasswordResetRememberMeToggled extends PasswordResetEvent {
  const PasswordResetRememberMeToggled();
}

final class PasswordResetProceeded extends PasswordResetEvent {
  const PasswordResetProceeded();
}
