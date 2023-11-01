part of 'app_cubit.dart';

enum AppStatus {
  // initial,
  authenticated,
  unauthenticated;

  // bool get isInitial => this == AppStatus.initial;
  bool get isAuthenticated => this == AppStatus.authenticated;
  // bool get isUnauthenticated => this == AppStatus.unauthenticated;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.statusMsg = '',
    this.user = AppUser.empty,
    this.departments = const [],
    this.firstLaunch = true,
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      status: AppStatus.values.byName(json['status'] as String),
      statusMsg: json['statusMsg'] as String,
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      departments: [for (final e in json['departments'] as List) e as String],
      firstLaunch: json['firstLaunch'] as bool,
    );
  }

  // const AppState.authenticated(AppUser user)
  //     : this._(status: AppStatus.authenticated, user: user);
  // const AppState.unauthenticated() : this._();

  final AppStatus status;
  final String statusMsg;
  final AppUser user;
  final List<String> departments;
  final bool firstLaunch;

  AppState copyWith({
    AppStatus? status,
    String? statusMsg,
    AppUser? user,
    List<String>? departments,
    bool? firstLaunch,
  }) {
    return AppState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      user: user ?? this.user,
      departments: departments ?? this.departments,
      firstLaunch: firstLaunch ?? this.firstLaunch,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status.name,
      'statusMsg': statusMsg,
      'user': user.toJson(),
      'departments': departments,
      'firstLaunch': firstLaunch,
    };
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, user, departments, firstLaunch];
}
