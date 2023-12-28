import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/repositories/notification_repo.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'notifications_state.dart';

class NotificationsCubit extends HydratedCubit<NotificationsState> {
  NotificationsCubit({required NotificationRepo notificationRepo})
      : _notificationRepo = notificationRepo,
        super(const NotificationsState()) {
    //-- Initialize Notifications data.
    _notificationRepo.notifications.then((record) {
      final (errorMsg, notifications) = record;
      emit(state.copyWith(statusMsg: errorMsg, notifications: notifications));
    });
  }

  final NotificationRepo _notificationRepo;

  @override
  NotificationsState? fromJson(Map<String, dynamic> json) {
    return NotificationsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotificationsState state) {
    return state.toJson();
  }
}
