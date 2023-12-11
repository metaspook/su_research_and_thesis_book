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
    this.designations = const [],
    this.departments = const [],
    this.theses = const [],
    this.researches = const [],
    this.firstLaunch = true,
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      status: AppStatus.values.byName(json['status'] as String),
      statusMsg: json['statusMsg'] as String,
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      designations: [for (final e in json['designations'] as List) e as String],
      departments: [for (final e in json['departments'] as List) e as String],
      theses: [for (final e in json['theses'] as List) e as Thesis],
      researches: [for (final e in json['researches'] as List) e as Research],
      firstLaunch: json['firstLaunch'] as bool,
    );
  }

  // const AppState.authenticated(AppUser user)
  //     : this._(status: AppStatus.authenticated, user: user);
  // const AppState.unauthenticated() : this._();

  final AppStatus status;
  final String statusMsg;
  final AppUser user;
  final List<String> designations;
  final List<String> departments;
  final List<Thesis>? theses;
  final List<Research>? researches;
  final bool firstLaunch;

  List<Publisher> get publishers => <Publisher>[
        // These
        if (theses != null)
          for (final e in theses!)
            if (e.publisher != null) e.publisher!,
        // Research
        if (researches != null)
          for (final e in researches!)
            if (e.publisher != null) e.publisher!,
      ].unique;

  Json toJson() {
    return <String, dynamic>{
      'status': status.name,
      'statusMsg': statusMsg,
      'user': user.toJson(),
      'designations': designations,
      'departments': departments,
      'theses': theses?.map((e) => e.toJson()).toList(),
      'researches': researches?.map((e) => e.toJson()).toList(),
      'firstLaunch': firstLaunch,
    };
  }

  AppState copyWith({
    AppStatus? status,
    String? statusMsg,
    AppUser? user,
    List<String>? designations,
    List<String>? departments,
    List<Thesis>? theses,
    List<Research>? researches,
    bool? firstLaunch,
  }) {
    return AppState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      user: user ?? this.user,
      designations: designations ?? this.designations,
      departments: departments ?? this.departments,
      theses: theses ?? this.theses,
      researches: researches ?? this.researches,
      firstLaunch: firstLaunch ?? this.firstLaunch,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      user,
      designations,
      departments,
      theses,
      researches,
      firstLaunch,
    ];
  }
}
