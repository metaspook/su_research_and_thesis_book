import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/repositories/repositories.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

part 'researches_state.dart';

class ResearchesCubit extends HydratedCubit<ResearchesState> {
  ResearchesCubit({
    required NotificationsRepo notificationsRepo,
    required ResearchesRepo researchesRepo,
  })  : _researchRepo = researchesRepo,
        _notificationRepo = notificationsRepo,
        super(const ResearchesState()) {
    //-- Initialize Researches subscription.
    _researchesSubscription = _researchRepo.stream.listen(_onResearches);
  }

  final ResearchesRepo _researchRepo;
  final NotificationsRepo _notificationRepo;
  late final StreamSubscription<List<Research>> _researchesSubscription;

  Future<void> _onResearches(List<Research> researches) async {
    // process notification if new data.
    if (state.notify) {
      final record = AppNotification(
        type: NotificationType.research,
        paperName: researches.last.title,
        paperId: researches.last.id,
        userName: researches.last.publisher?.name,
      );
      await _notificationRepo.add(record);
    }
    final notify = state.notify ? null : true;
    emit(state.copyWith(notify: notify, researches: researches));
  }

  @override
  ResearchesState? fromJson(Map<String, dynamic> json) =>
      ResearchesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ResearchesState state) => state.toJson();

  @override
  Future<void> close() {
    _researchesSubscription.cancel();
    return super.close();
  }
}
