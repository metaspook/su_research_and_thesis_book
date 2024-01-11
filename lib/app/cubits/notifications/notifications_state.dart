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
    this.notifications = const [],
    this.unseenCount = 0,
  });

  factory NotificationsState.fromJson(Map<String, dynamic> json) {
    return NotificationsState(
      notifications: [
        ...List<Map<String, dynamic>>.from(json['notifications'] as List)
            .map(AppNotification.fromJson),
      ],
    );
  }

  final NotificationsStatus status;
  final String? statusMsg;
  final List<AppNotification> notifications;
  final int unseenCount;

  NotificationsState copyWith({
    NotificationsStatus? status,
    String? statusMsg,
    List<AppNotification>? notifications,
    int? unseenCount,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      notifications: notifications ?? this.notifications,
      unseenCount: unseenCount ?? this.unseenCount,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'notifications': [...notifications.map((e) => e.toJson())],
      };

  @override
  List<Object?> get props => [status, statusMsg, notifications, unseenCount];
}
