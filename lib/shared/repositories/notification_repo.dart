import 'dart:async';

import 'package:cache/cache.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

class NotificationRepo {
  //-- Config
  final _cache = const Cache<List<String>>('notifications');
  final _errorMsgDesignationsNotFound = 'Designations not found!';
  final _errorMsgDesignations = "Couldn't get the designations!";
  final _controller = StreamController<List<NotificationRecord>>();

  //-- Public APIs
  /// Emit list of notification.
  Stream<List<NotificationRecord>> get stream => _controller.stream;
  // Stream<List<NotificationRecord>> get stream =>
  //     _controller.stream.asBroadcastStream();

  Future<void> add(NotificationRecord record) async {
    record.doPrint('FOUD HERE1: ');
    final notificationRecords = [record];
    notificationRecords.doPrint('FOUD HERE2: ');

    _controller.add(notificationRecords);
  }

  Future<void> remove(NotificationRecord record) async {
    final notificationRecords = await _controller.stream.first
      ..remove(record);
    _controller.add(notificationRecords);
  }

  void dispose() {
    _controller.close();
  }
}
