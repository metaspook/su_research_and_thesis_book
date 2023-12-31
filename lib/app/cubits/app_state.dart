part of 'app_cubit.dart';

enum AppStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == AppStatus.authenticated;
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
    // final userJson = Map<String, dynamic>.from(json['user'] as Map);
    return AppState(
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      firstLaunch: json['firstLaunch'] as bool,
    );
  }

  final AppStatus status;
  final String? statusMsg;
  final AppUser user;
  final bool firstLaunch;

  Map<String, dynamic> toJson() => <String, dynamic>{
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
        statusMsg: this.statusMsg,
        user: user ?? this.user,
        firstLaunch: firstLaunch ?? this.firstLaunch,
      );

  @override
  List<Object?> get props => [status, statusMsg, user, firstLaunch];
}
