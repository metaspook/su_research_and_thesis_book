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
    this.records = const [],
  });

  factory NotificationsState.fromJson(Map<String, dynamic> json) {
    return NotificationsState(
      records: [
        for (final recordJson
            in List<Map<String, dynamic>>.from(json['records'] as List))
          (
            type: NotificationType.values.byName(recordJson['type']! as String),
            paperName: recordJson['paperName'] as String?,
            paperId: recordJson['paperId'] as String?,
            userName: recordJson['userName'] as String?
          ),
      ],
    );
  }

  final NotificationsStatus status;
  final String? statusMsg;
  final List<NotificationRecord> records;

  NotificationsState copyWith({
    NotificationsStatus? status,
    String? statusMsg,
    List<NotificationRecord>? records,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      records: records ?? this.records,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'records': [
          for (final record in records)
            {
              'type': record.type.name,
              'paperName': record.paperName,
              'paperId': record.paperId,
              'userName': record.userName,
            },
        ],
      };

  @override
  List<Object?> get props => [status, statusMsg, records];
}
