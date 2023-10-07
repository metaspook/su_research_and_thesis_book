import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit({required ThesisRepo thesisRepo})
      : _thesisRepo = thesisRepo,
        super(const BookmarksState()) {
    const thesis = Thesis(id: 'id', userId: 'userId');
    final theses = [
      for (var i = 0; i < 10; i++) thesis,
    ];
    emit(state.copyWith(theses: theses));
  }

  final ThesisRepo _thesisRepo;

  void onSelected(Thesis thesis) {
    final selectedThesis = [...state.selectedTheses, thesis];
    emit(state.copyWith(selectedTheses: selectedThesis));
  }

  bool isSelected(Thesis thesis) {
    return state.selectedTheses.contains(thesis);
  }

  void onRemoved() {
    final theses = [...state.theses]..removeWhere(isSelected);
    emit(state.copyWith(theses: theses));
  }

  // void onChangedSearch(String value) {
  //   emit(state.copyWith(search: value));
  // }
}
