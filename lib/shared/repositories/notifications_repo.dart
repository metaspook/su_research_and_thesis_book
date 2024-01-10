import 'dart:async';

import 'package:cache/cache.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';

class NotificationsRepo {
  //-- Config
  final _controller = StreamController<List<AppNotification>>();
  final _cache = const Cache<List<AppNotification>>('notifications');

  //-- Public APIs
  /// Emit list of notification.
  Stream<List<AppNotification>> get stream =>
      _controller.stream.map((notifications) => _cache.value = notifications);

  Future<void> add(AppNotification notification) async {
    final notifications = [...?_cache.value, notification];
    _controller.add(notifications);
  }

  Future<void> remove(AppNotification notification) async {
    final notifications = [...?_cache.value]..remove(notification);
    _controller.add(notifications);
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
