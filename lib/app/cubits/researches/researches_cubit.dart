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
        _notificationRepo = notificationRepo,
        _researchRepo = researchRepo,
        super(const ResearchesState()) {
    //-- Initialize Authentication subscription.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Authenticated: Initialize Researches data.
        _researchesSubscription =
            _researchRepo.stream.listen((researches) async {
          emit(state.copyWith(researches: researches));
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
  final NotificationRepo _notificationRepo;
  final ResearchRepo _researchRepo;
  late final StreamSubscription<User?> _userSubscription;
  late final StreamSubscription<List<Research>> _researchesSubscription;

  @override
  ResearchesState? fromJson(Map<String, dynamic> json) {
    return ResearchesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ResearchesState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
