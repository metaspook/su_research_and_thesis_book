part of 'app_cubit.dart';

enum AppStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == AppStatus.authenticated;
  // bool get hasMessage =>
  //     this == AppStatus.authenticated || this == AppStatus.unauthenticated;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.statusMsg,
    this.user = AppUser.empty,
    this.firstLaunch = true,
  });

  // const AppState.authenticated(AppUser user)
  //     : this._(status: AppStatus.authenticated, user: user);
  // const AppState.unauthenticated() : this._();

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      // status: AppStatus.values.byName(json['status'] as String),
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      firstLaunch: json['firstLaunch'] as bool,
    );
  }

  final AppStatus status;
  final String? statusMsg;
  final AppUser user;
  final bool firstLaunch;
  bool get hasMessage => statusMsg != null;

  Json toJson() => <String, dynamic>{
        // 'status': status.name,
        'user': user.toJson(),
        'firstLaunch': firstLaunch,
      };

  AppState copyWith({
    AppStatus? status,
    String? statusMsg,
    AppUser? user,
    bool? firstLaunch,
  }) =>
      AppState(
        status: status ?? this.status,
        statusMsg: statusMsg,
        user: user ?? this.user,
        firstLaunch: firstLaunch ?? this.firstLaunch,
      );

  @override
  List<Object?> get props => [status, statusMsg, user, firstLaunch];
}
