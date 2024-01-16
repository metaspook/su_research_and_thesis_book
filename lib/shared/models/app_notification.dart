import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';

enum NotificationType {
  research('published research paper '),
  thesis('published thesis paper '),
  comments('commented on ');

  const NotificationType(this.data);
  final String data;
}

final class AppNotification extends Equatable {
  const AppNotification({
    required this.type,
    required this.paper,
    required this.userName,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      type: NotificationType.values.byName(json['type'] as String),
      paper: Paper.fromJson(json['paper'] as Map<String, dynamic>),
      userName: json['userName'] as String?,
    );
  }

  final NotificationType type;
  final Paper paper;
  // userName instead of publisherName as its gonna use for comments also.
  final String? userName;

  AppNotification copyWith({
    NotificationType? type,
    Paper? paper,
    String? userName,
  }) {
    return AppNotification(
      type: type ?? this.type,
      paper: paper ?? this.paper,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type.name,
      'paper': paper.toJson(),
      'userName': userName,
    };
  }

  @override
  List<Object?> get props => [type, paper, userName];
}
