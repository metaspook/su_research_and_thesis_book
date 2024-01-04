import 'dart:async';

import 'package:su_thesis_book/shared/models/models.dart';

class NotificationsRepo {
  //-- Config
  final _controller = StreamController<List<AppNotification>>.broadcast();

  //-- Public APIs
  /// Emit list of notification.
  Stream<List<AppNotification>> get stream => _controller.stream;

  Future<void> add(AppNotification notification) async {
    final notificationRecords = [
      ...await _controller.stream.first,
      notification,
    ];
    _controller.add(notificationRecords);
  }

  Future<void> remove(AppNotification notification) async {
    final notificationRecords = [...await _controller.stream.first]
      ..remove(notification);
    _controller.add(notificationRecords);
  }

  void renewBy(List<AppNotification> notifications) {
    _controller.add(notifications);
  }

  void removeAll() {
    _controller.add(const []);
  }

  void dispose() {
    _controller.close();
  }
}
