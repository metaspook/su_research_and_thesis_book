part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileEdited extends ProfileEvent {
  const ProfileEdited({
    this.name,
    this.role,
    this.email,
    this.password,
    this.phone,
    this.photoUrl,
  });

  final String? name;
  final String? role;
  final String? email;
  final String? password;
  final String? phone;
  final String? photoUrl;

  @override
  List<Object?> get props => [name, role, email, password, phone, photoUrl];
}

final class ProfileObscurePasswordToggled extends ProfileEvent {
  const ProfileObscurePasswordToggled();
}

final class ProfileEditModeToggled extends ProfileEvent {
  const ProfileEditModeToggled();
}

final class ProfileEditModeCanceled extends ProfileEvent {
  const ProfileEditModeCanceled();
}

final class ProfileSignedOut extends ProfileEvent {
  const ProfileSignedOut();
}
