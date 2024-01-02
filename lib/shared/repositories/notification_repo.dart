import 'dart:async';

import 'package:su_thesis_book/shared/models/models.dart';

class NotificationRepo {
  //-- Config
  final _controller = StreamController<List<NotificationRecord>>();

  //-- Public APIs
  /// Emit list of notification.
  Stream<List<NotificationRecord>> get stream => _controller.stream;

  Future<void> add(NotificationRecord record) async {
    final notificationRecords = await _controller.stream.first
      ..add(record);
    _controller.add(notificationRecords);
  }

  Future<void> remove(NotificationRecord record) async {
    final notificationRecords = await _controller.stream.first
      ..remove(record);
    _controller.add(notificationRecords);
  }

  void renewBy(List<NotificationRecord> records) {
    _controller.add(records);
  }

  void removeAll() {
    _controller.add([]);
  }

  void dispose() {
    _controller.close();
  }
}
