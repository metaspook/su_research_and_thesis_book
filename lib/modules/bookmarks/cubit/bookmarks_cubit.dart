import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/functions.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit({required BookmarkRepo bookmarkRepo})
      : _bookmarkRepo = bookmarkRepo,
        super(const BookmarksState()) {
    //-- Initialize Research Bookmark subscription.
    _researchIdsSubscription =
        _bookmarkRepo.ids(PaperType.research).listen((researchIds) async {
      emit(state.copyWith(researchIds: researchIds));
    });
    //-- Initialize Thesis Bookmark subscription.
    _thesisIdsSubscription =
        _bookmarkRepo.ids(PaperType.thesis).listen((thesisIds) async {
      emit(state.copyWith(thesisIds: thesisIds));
    });
    // final thesis = Thesis(id: uuid, userId: 'userId');
    emit(state.copyWith(status: BookmarksStatus.loading));
    Future.delayed(const Duration(seconds: 2), () {
      final theses = [
        for (var i = 0; i < 10; i++)
          Thesis(id: 'uuid', publisher: null, title: uuid.substring(25)),
      ];
      emit(state.copyWith(status: BookmarksStatus.success, theses: theses));
    });
  }

  final BookmarkRepo _bookmarkRepo;
  late final StreamSubscription<List<String>> _researchIdsSubscription;
  late final StreamSubscription<List<String>> _thesisIdsSubscription;

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
    final theses = [...state.theses!]..removeWhere(selectedTheses.remove);
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

  @override
  Future<void> close() {
    _researchIdsSubscription.cancel();
    _thesisIdsSubscription.cancel();
    return super.close();
  }
}
