import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'notifications_state.dart';

class NotificationsCubit extends HydratedCubit<NotificationsState> {
  NotificationsCubit({required NotificationRepo notificationRepo})
      : _notificationRepo = notificationRepo,
        super(const NotificationsState()) {
    //-- Initialize Notifications subscription.
    _notificationsSubscription = _notificationRepo.stream.listen((records) {
      emit(state.copyWith(records: records));
    });
  }

  final NotificationRepo _notificationRepo;
  late final StreamSubscription<List<NotificationRecord>>
      _notificationsSubscription;

  Future<void> onDismissed(NotificationRecord record) async {
    await _notificationRepo.remove(record);
    final records = state.records..remove(record);
    emit(state.copyWith(records: records));
  }

  void onAllDismissed() {
    _notificationRepo.removeAll();
    emit(state.copyWith(records: []));
  }

  @override
  NotificationsState? fromJson(Map<String, dynamic> json) =>
      NotificationsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NotificationsState state) => state.toJson();

  @override
  Future<void> close() {
    _notificationsSubscription.cancel();
    _notificationRepo.dispose();
    return super.close();
  }
}
