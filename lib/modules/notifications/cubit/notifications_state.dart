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
    this.notifications,
  });

  factory NotificationsState.fromJson(Map<String, dynamic> json) {
    return NotificationsState(
      notifications: [
        for (final e in json['notifications'] as List) e as String
      ],
    );
  }

  final NotificationsStatus status;
  final String? statusMsg;
  final List<String>? notifications;
  bool get hasMessage => statusMsg != null;

  Json toJson() {
    return <String, dynamic>{
      'notifications': notifications,
    };
  }

  NotificationsState copyWith({
    NotificationsStatus? status,
    String? statusMsg,
    List<String>? notifications,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      statusMsg: statusMsg,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      notifications,
    ];
  }
}
