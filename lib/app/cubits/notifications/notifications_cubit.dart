import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/repositories/repositories.dart';

part 'notifications_state.dart';

class NotificationsCubit extends HydratedCubit<NotificationsState> {
  NotificationsCubit({required NotificationsRepo notificationsRepo})
      : _notificationRepo = notificationsRepo,
        super(const NotificationsState()) {
    //-- Initialize Notifications subscription.
    _notificationsSubscription =
        _notificationRepo.stream.listen((notifications) {
      emit(
        state.copyWith(
          notifications: notifications,
          unseenCount: state.unseenCount + 1,
        ),
      );
    });
  }

  final NotificationsRepo _notificationRepo;
  late final StreamSubscription<List<AppNotification>>
      _notificationsSubscription;

  void onDecrementUnseenCount() {
    if (state.unseenCount > 0) {
      emit(state.copyWith(unseenCount: state.unseenCount - 1));
    }
  }

  Future<void> onDismissed(AppNotification notification) async {
    await _notificationRepo.remove(notification);
    final notifications = state.notifications..remove(notification);
    emit(state.copyWith(notifications: notifications));
  }

  void onAllDismissed() {
    _notificationRepo.removeAll();
    emit(state.copyWith(notifications: []));
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
