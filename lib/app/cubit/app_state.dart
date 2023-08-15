part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated, unknown }

class AppState extends Equatable {
  const AppState({this.status = AppStatus.unknown});

  final AppStatus status;

  AppState copyWith({
    AppStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
