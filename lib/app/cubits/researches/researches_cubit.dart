import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'researches_state.dart';

class ResearchesCubit extends HydratedCubit<ResearchesState> {
  ResearchesCubit({
    required AuthRepo authRepo,
    required NotificationRepo notificationRepo,
    required ResearchRepo researchRepo,
  })  : _authRepo = authRepo,
        _researchRepo = researchRepo,
        super(const ResearchesState()) {
    //-- Initialize Authentication subscription.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Authenticated: Initialize Researches data.
        _researchesSubscription =
            _researchRepo.stream.listen((researches) async {
          // process notification if new data.
          if (state.notify) {
            final record = (
              type: NotificationType.research,
              paperName: researches.last.title,
              userName: researches.last.publisher?.name
            );
            await notificationRepo.add(record);
          }
          final notify = state.notify ? null : true;
          emit(state.copyWith(notify: notify, researches: researches));
        });
      } else {
        // Unauthenticated: Reset cached and current state.
        await _researchesSubscription.cancel();
        await clear();
        emit(const ResearchesState());
      }
    });
  }

  final AuthRepo _authRepo;
  final ResearchRepo _researchRepo;
  late final StreamSubscription<User?> _userSubscription;
  late final StreamSubscription<List<Research>> _researchesSubscription;

  @override
  ResearchesState? fromJson(Map<String, dynamic> json) =>
      ResearchesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ResearchesState state) => state.toJson();

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
