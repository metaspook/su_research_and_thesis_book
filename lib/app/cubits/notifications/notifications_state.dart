part of 'notifications_cubit.dart';

enum NotificationsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == NotificationsStatus.loading;
}

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.statusMsg,
    this.notificationRecords = const [],
  });

  final NotificationsStatus status;
  final String? statusMsg;
  final List<NotificationRecord> notificationRecords;
  // bool get hasMessage => statusMsg != null;

  NotificationsState copyWith({
    NotificationsStatus? status,
    String? statusMsg,
    List<NotificationRecord>? notificationRecords,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      notificationRecords: notificationRecords ?? this.notificationRecords,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, notificationRecords];
}
