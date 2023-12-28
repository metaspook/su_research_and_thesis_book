import 'dart:async';

import 'package:cache/cache.dart';
import 'package:su_thesis_book/shared/models/models.dart';

class NotificationRepo {
  //-- Config
  final _cache = const Cache<List<String>>('notifications');
  final _errorMsgDesignationsNotFound = 'Designations not found!';
  final _errorMsgDesignations = "Couldn't get the designations!";
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
}
