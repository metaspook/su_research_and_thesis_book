import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'thesis_state.dart';

class ThesisCubit extends Cubit<ThesisState> {
  ThesisCubit({required ThesisRepo thesisRepo, required Thesis thesis})
      : _thesisRepo = thesisRepo,
        super(ThesisState(thesis: thesis)) {
    //-- Increment Theses views.
    incrementViews(state.thesis);
  }

  final ThesisRepo _thesisRepo;
  static bool _firstView = true;

  /// Increment Thesis view count.
  /// * Increment only once if `firstView` is `true`.
  Future<void> incrementViews(Thesis thesis, {bool firstView = true}) async {
    if (_firstView == firstView) {
      final value = {'views': (thesis.views ?? 0) + 1};
      final errorMsg = await _thesisRepo.update(thesis.id, value: value);
      if (errorMsg == null) {
        if (_firstView) _firstView = !_firstView;
      } else {
        emit(
          state.copyWith(
            status: ThesisStatus.failure,
            statusMsg: "Couldn't increment Thesis views!",
          ),
        );
      }
    }
  }
}
