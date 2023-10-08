import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/functions.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit({required ThesisRepo thesisRepo})
      : _thesisRepo = thesisRepo,
        super(const BookmarksState()) {
    // final thesis = Thesis(id: uuid, userId: 'userId');
    final theses = [
      for (var i = 0; i < 10; i++)
        Thesis(id: 'uuid', userId: 'userId', name: uuid.substring(25)),
    ];
    emit(state.copyWith(theses: theses));
  }

  final ThesisRepo _thesisRepo;

  void onSelectionToggled(Thesis thesis) {
    final selectedThesis = [...state.selectedTheses];
    // Add if not exist or Remove if exist.
    selectedThesis.contains(thesis)
        ? selectedThesis.remove(thesis)
        : selectedThesis.add(thesis);
    emit(
      state.copyWith(
        status: BookmarksStatus.selecting,
        selectedTheses: selectedThesis,
      ),
    );
  }

  void onRemoved() {
    final selectedTheses = [...state.selectedTheses];
    final theses = [...state.theses]..removeWhere(selectedTheses.remove);
    emit(state.copyWith(theses: theses, selectedTheses: selectedTheses));
  }

  void onAllSelected() {
    emit(
      state.copyWith(
        status: BookmarksStatus.selecting,
        selectedTheses: state.theses,
      ),
    );
  }

  void onAllDeselected() {
    emit(
      state.copyWith(status: BookmarksStatus.initial, selectedTheses: const []),
    );
  }

  void onAllRemoved() {
    emit(
      state.copyWith(
        status: BookmarksStatus.initial,
        theses: const [],
        selectedTheses: const [],
      ),
    );
  }
}
