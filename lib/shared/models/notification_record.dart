enum NotificationType {
  research('published research paper '),
  thesis('published thesis paper '),
  comment('commented on ');

  const NotificationType(this.data);
  final String data;
}

typedef NotificationRecord = ({
  NotificationType type,
  String paperName,
  String userName
});
