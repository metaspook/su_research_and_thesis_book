import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'theses_state.dart';

class ThesesCubit extends HydratedCubit<ThesesState> {
  ThesesCubit({
    required NotificationsRepo notificationsRepo,
    required ThesesRepo thesesRepo,
  })  : _thesisRepo = thesesRepo,
        _notificationRepo = notificationsRepo,
        super(const ThesesState()) {
    //-- Initialize Theses subscription.
    _thesesSubscription = _thesisRepo.stream.listen(_onTheses);
  }

  final ThesesRepo _thesisRepo;
  final NotificationsRepo _notificationRepo;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;

  Future<void> _onTheses(List<Thesis> theses) async {
    // process notification if new data.
    if (state.notify) {
      final record = AppNotification(
        type: NotificationType.thesis,
        paperName: theses.last.title,
        paperId: theses.last.id,
        userName: theses.last.publisher?.name,
      );
      await _notificationRepo.add(record);
    }
    final notify = state.notify ? null : true;
    emit(state.copyWith(notify: notify, theses: theses));
  }

  @override
  ThesesState? fromJson(Map<String, dynamic> json) =>
      ThesesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ThesesState state) => state.toJson();

  @override
  Future<void> close() {
    _thesesSubscription.cancel();
    return super.close();
  }
}
