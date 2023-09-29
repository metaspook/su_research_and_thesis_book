part of 'profile_update_bloc.dart';

sealed class ProfileUpdateEvent extends Equatable {
  const ProfileUpdateEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileUpdateEdited extends ProfileUpdateEvent {
  const ProfileUpdateEdited({
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

final class ProfileUpdateSaved extends ProfileUpdateEvent {
  const ProfileUpdateSaved({this.credential});

  final AuthCredential? credential;

  @override
  List<Object?> get props => [credential];
}

final class ProfileUpdateObscurePasswordToggled extends ProfileUpdateEvent {
  const ProfileUpdateObscurePasswordToggled();
}

final class ProfileUpdatePhotoPicked extends ProfileUpdateEvent {
  const ProfileUpdatePhotoPicked(this.photoPath, {this.statusMsg});

  final String? photoPath;
  final String? statusMsg;

  @override
  List<Object?> get props => [photoPath, statusMsg];
}
