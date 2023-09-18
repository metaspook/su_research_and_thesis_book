import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required ThesisRepo thesisRepo})
      : _thesisRepo = thesisRepo,
        super(const HomeState()) {
    //-- Thesis data subscription.
    _thesesSubscription = _thesisRepo.thesesStream.listen((theses) async {
      emit(state.copyWith(status: HomeStatus.loading));

      if (theses.isNotEmpty) {
        emit(state.copyWith(status: HomeStatus.success, theses: theses));
      }
    });
  }

  final ThesisRepo _thesisRepo;

  late final StreamSubscription<List<Thesis>> _thesesSubscription;

  @override
  Future<void> close() {
    _thesesSubscription.cancel();
    return super.close();
  }
}
