import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'thesis_state.dart';

class ThesisCubit extends Cubit<ThesisState> {
  ThesisCubit({required ThesisRepo thesisRepo, required Thesis thesis})
      : _thesisRepo = thesisRepo,
        _thesis = thesis,
        super(const ThesisState()) {
    //-- Theses data subscription.
    // incrementViews(thesis);
  }

  Future<void> incrementViews(Thesis thesis) async {
    // final views = _thesis.views ?? 0;
    // if (views == 0) {}
    final value = {'views': (thesis.views ?? 0) + 1};
    await _thesisRepo.update(thesis.id, value: value);
  }

  final Thesis _thesis;
  final ThesisRepo _thesisRepo;
}
