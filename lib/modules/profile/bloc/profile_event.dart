part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileEdited extends ProfileEvent {
  const ProfileEdited({
    this.name,
    this.email,
    this.phone,
    this.password,
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? password;

  @override
  List<Object?> get props => [name, email, phone, password];
}

final class ProfileEditModeToggled extends ProfileEvent {
  const ProfileEditModeToggled();
}

final class ProfileEditSaved extends ProfileEvent {
  const ProfileEditSaved();
}

final class ProfileObscurePasswordToggled extends ProfileEvent {
  const ProfileObscurePasswordToggled();
}

final class ProfilePhotoPicked extends ProfileEvent {
  const ProfilePhotoPicked(this.photoPath, {this.statusMsg});

  final String? photoPath;
  final String? statusMsg;

  @override
  List<Object?> get props => [photoPath, statusMsg];
}

final class ProfileSignedOut extends ProfileEvent {
  const ProfileSignedOut();
}
