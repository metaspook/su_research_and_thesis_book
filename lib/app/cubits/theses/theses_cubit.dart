import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'theses_state.dart';

class ThesesCubit extends HydratedCubit<ThesesState> {
  ThesesCubit({
    required AuthRepo authRepo,
    required NotificationRepo notificationRepo,
    required ThesisRepo thesisRepo,
  })  : _authRepo = authRepo,
        _thesisRepo = thesisRepo,
        _notificationRepo = notificationRepo,
        super(const ThesesState()) {
    //-- Initialize Authentication subscription.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Authenticated: Initialize Theses data.
        _thesesSubscription = _thesisRepo.stream.listen(_onTheses);
      } else {
        // Unauthenticated: Reset cached and current state.
        await _thesesSubscription.cancel();
        await clear();
        emit(const ThesesState());
      }
    });
  }

  final AuthRepo _authRepo;
  final ThesisRepo _thesisRepo;
  final NotificationRepo _notificationRepo;
  late final StreamSubscription<User?> _userSubscription;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;

  Future<void> _onTheses(List<Thesis> theses) async {
    // process notification if new data.
    if (state.notify) {
      final record = (
        type: NotificationType.thesis,
        paperName: theses.last.title,
        paperId: theses.last.id,
        userName: theses.last.publisher?.name
      );
      await _notificationRepo.add(record);
    }
    final notify = state.notify ? null : true;
    emit(state.copyWith(notify: notify, theses: theses));
  }

  // Future<Thesis?> thesisBy(String id)  =>  _thesisRepo.thesisById(id);

  @override
  ThesesState? fromJson(Map<String, dynamic> json) =>
      ThesesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ThesesState state) => state.toJson();

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
