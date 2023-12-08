import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required ThesisRepo thesisRepo,
    required ResearchRepo researchRepo,
  })  : _thesisRepo = thesisRepo,
        _researchRepo = researchRepo,
        super(const HomeState()) {
    emit(state.copyWith(status: HomeStatus.loading));
    //-- Theses data subscription.
    _thesesSubscription = _thesisRepo.stream.listen((theses) async {
      if (theses.isNotEmpty) {
        emit(state.copyWith(status: HomeStatus.success, theses: theses));
      }
    });
    //-- Researches data subscription.
    _researchesSubscription = _researchRepo.stream.listen((researches) async {
      if (researches.isNotEmpty) {
        emit(
          state.copyWith(status: HomeStatus.success, researches: researches),
        );
      }
    });
  }

  final ThesisRepo _thesisRepo;
  final ResearchRepo _researchRepo;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;
  late final StreamSubscription<List<Research>> _researchesSubscription;

  Future<void> incrementViews(Thesis thesis) async {
    // final views = (thesis.views ?? 0);
    // if (views ==) {

    // }
    final value = {'views': (thesis.views ?? 0) + 1};
    await _thesisRepo.update(thesis.id, value: value);
  }

  void onDestinationSelected(int index) {
    emit(state.copyWith(viewIndex: index));
  }

  @override
  Future<void> close() {
    _thesesSubscription.cancel();
    _researchesSubscription.cancel();
    return super.close();
  }
}
