enum NotificationType {
  research('published research paper '),
  thesis('published thesis paper '),
  comment('commented on ');

  const NotificationType(this.data);
  final String data;
}

typedef NotificationRecord = ({
  NotificationType type,
  String? paperName,
  String? paperId,
  // userName instead of publisherName as its gonna use for comments also.
  String? userName,
});
