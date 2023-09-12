part of 'app_cubit.dart';

enum AppStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == AppStatus.authenticated;
  bool get isUnauthenticated => this == AppStatus.unauthenticated;
}

final class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unauthenticated,
    this.statusMsg = '',
    this.user = AppUser.empty,
  });

  const AppState.authenticated({required AppUser user})
      : this._(status: AppStatus.authenticated, user: user);
  const AppState.unauthenticated() : this._();

  final AppStatus status;
  final String statusMsg;
  final AppUser user;

  AppState copyWith({
    AppStatus? status,
    String? statusMsg,
    AppUser? user,
  }) {
    return AppState._(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, user];
}
