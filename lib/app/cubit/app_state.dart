part of 'app_cubit.dart';

enum AppStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == AppStatus.authenticated;
  bool get isUnauthenticated => this == AppStatus.unauthenticated;
}

final class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.statusMsg = '',
    this.user = AppUser.empty,
    this.userCredential,
  });

  final AppStatus status;
  final String statusMsg;
  final AppUser user;
  final UserCredential? userCredential;

  AppState copyWith({
    AppStatus? status,
    String? statusMsg,
    AppUser? user,
    UserCredential? userCredential,
  }) {
    return AppState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      user: user ?? this.user,
      userCredential: userCredential ?? this.userCredential,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, user, userCredential];
}
