part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated, unknown }

final class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unknown,
    this.statusMsg = '',
    this.user,
  });

  final AppStatus status;
  final String statusMsg;
  final AppUser? user;

  AppState copyWith({
    AppStatus? status,
    String? statusMsg,
    AppUser? user,
  }) {
    return AppState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, user];
}
