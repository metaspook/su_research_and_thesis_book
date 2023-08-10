part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpEdited extends SignUpEvent {
  const SignUpEdited({this.name, this.email, this.password, this.phone});

  final String? name;
  final String? email;
  final String? password;
  final String? phone;

  @override
  List<Object?> get props => [name, email, password, phone];
}

final class SignUpCameraImagePicked extends SignUpEvent {}

final class SignUpGalleryImagePicked extends SignUpEvent {}
