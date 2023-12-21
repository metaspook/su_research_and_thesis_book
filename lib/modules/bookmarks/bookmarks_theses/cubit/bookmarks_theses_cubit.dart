import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'bookmarks_theses_state.dart';

class BookmarksThesesCubit extends Cubit<BookmarksThesesState> {
  BookmarksThesesCubit({required BookmarkRepo bookmarkRepo})
      : _bookmarkRepo = bookmarkRepo,
        super(const BookmarksThesesState()) {
    //-- Initialize Thesis Bookmark subscription.
    _thesisIdsSubscription =
        _bookmarkRepo.ids(PaperType.thesis).listen((thesisIds) async {
      emit(state.copyWith(thesisIds: thesisIds));
    });
  }

  final BookmarkRepo _bookmarkRepo;
  late final StreamSubscription<List<String>> _thesisIdsSubscription;

  void onSelectionToggled(Thesis thesis) {
    final selectedThesis = [...state.selectedTheses];
    // Add if not exist or Remove if exist.
    selectedThesis.contains(thesis)
        ? selectedThesis.remove(thesis)
        : selectedThesis.add(thesis);
    emit(
      state.copyWith(
        status: BookmarksThesesStatus.selecting,
        selectedTheses: selectedThesis,
      ),
    );
  }

  void onRemoved() {
    final selectedTheses = [...state.selectedTheses];
    final theses = [...state.theses!]..removeWhere(selectedTheses.remove);
    emit(state.copyWith(theses: theses, selectedTheses: selectedTheses));
  }

  void onAllSelected() {
    emit(
      state.copyWith(
        status: BookmarksThesesStatus.selecting,
        selectedTheses: state.theses,
      ),
    );
  }

  void onAllDeselected() {
    emit(
      state.copyWith(
        status: BookmarksThesesStatus.initial,
        selectedTheses: const [],
      ),
    );
  }

  void onAllRemoved() {
    emit(
      state.copyWith(
        status: BookmarksThesesStatus.initial,
        theses: const [],
        selectedTheses: const [],
      ),
    );
  }

  @override
  Future<void> close() {
    _thesisIdsSubscription.cancel();
    return super.close();
  }
}
