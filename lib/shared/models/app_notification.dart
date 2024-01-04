import 'package:equatable/equatable.dart';

enum NotificationType {
  research('published research paper '),
  thesis('published thesis paper '),
  comment('commented on ');

  const NotificationType(this.data);
  final String data;
}

final class AppNotification extends Equatable {
  const AppNotification({
    required this.type,
    required this.paperId,
    required this.paperName,
    required this.userName,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      type: NotificationType.values.byName(json['type'] as String),
      paperId: json['paperId'] as String,
      paperName: json['paperName'] as String?,
      userName: json['userName'] as String?,
    );
  }

  final NotificationType type;
  final String paperId;
  final String? paperName;
  // userName instead of publisherName as its gonna use for comments also.
  final String? userName;

  AppNotification copyWith({
    NotificationType? type,
    String? paperId,
    String? paperName,
    String? userName,
  }) {
    return AppNotification(
      type: type ?? this.type,
      paperId: paperId ?? this.paperId,
      paperName: paperName ?? this.paperName,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type.name,
      'paperId': paperId,
      'paperName': paperName,
      'userName': userName,
    };
  }

  @override
  List<Object?> get props => [type, paperId, paperName, userName];
}
