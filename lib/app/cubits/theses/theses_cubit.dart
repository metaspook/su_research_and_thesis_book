import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'theses_state.dart';

class ThesesCubit extends HydratedCubit<ThesesState> {
  ThesesCubit({required AuthRepo authRepo, required ThesisRepo thesisRepo})
      : _authRepo = authRepo,
        _thesisRepo = thesisRepo,
        super(const ThesesState()) {
    //-- Initialize Authentication subscription.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Logic after User is authenticated.
        //-- Initialize Theses data subscription.
        _thesesSubscription = _thesisRepo.stream.listen((theses) async {
          emit(state.copyWith(theses: theses));
        });
      } else {
        await _thesesSubscription.cancel();
        await clear();
      }
    });
  }

  final AuthRepo _authRepo;
  final ThesisRepo _thesisRepo;
  late final StreamSubscription<User?> _userSubscription;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;

  @override
  ThesesState? fromJson(Map<String, dynamic> json) {
    return ThesesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThesesState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
