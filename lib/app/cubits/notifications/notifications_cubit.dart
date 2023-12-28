import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required NotificationRepo notificationRepo})
      : _notificationRepo = notificationRepo,
        super(const NotificationsState()) {
    //-- Initialize Notifications subscription.
    _notificationsSubscription = _notificationRepo.stream.listen((records) {
      records.doPrint('FOUND NOTI: ');
      emit(state.copyWith(notificationRecords: records));
    });
  }

  final NotificationRepo _notificationRepo;
  late final StreamSubscription<List<NotificationRecord>>
      _notificationsSubscription;

  @override
  Future<void> close() {
    _notificationsSubscription.cancel();
    _notificationRepo.dispose();
    return super.close();
  }
}
