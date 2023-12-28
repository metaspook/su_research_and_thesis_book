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
        super(const ThesesState()) {
    //-- Initialize Authentication subscription.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Authenticated: Initialize Theses data.
        _thesesSubscription = _thesisRepo.stream.listen((theses) async {
          // process notification if new data.
          if (state.notify) {
            final record = (
              type: NotificationType.thesis,
              paperName: theses.last.title,
              userName: theses.last.publisher?.name
            );
            await notificationRepo.add(record);
          }
          final notify = state.notify ? null : true;
          emit(state.copyWith(notify: notify, theses: theses));
        });
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
  late final StreamSubscription<User?> _userSubscription;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;

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
