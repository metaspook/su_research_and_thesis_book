import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'bookmarks_researches_state.dart';

class BookmarksResearchesCubit extends Cubit<BookmarksResearchesState> {
  BookmarksResearchesCubit({
    required ResearchesRepo researchesRepo,
    required BookmarksRepo bookmarksRepo,
  })  : _bookmarkRepo = bookmarksRepo,
        _researchRepo = researchesRepo,
        super(const BookmarksResearchesState()) {
    // Initialize Research Bookmark subscription.
    _researchBookmarksSubscription = _bookmarkRepo
        .streamByType(PaperType.research)
        .listen((researchBookmarks) async {
      //-- Parse bookmarked researches.
      final bookmarkedResearchIds =
          researchBookmarks.map((bookmark) => bookmark.paperId);

      final bookmarkedResearches = <Research>[];
      for (final bookmarkedResearchId in bookmarkedResearchIds) {
        final bookmarkedResearch =
            await _researchRepo.researchById(bookmarkedResearchId);
        if (bookmarkedResearch != null) {
          bookmarkedResearches.add(bookmarkedResearch);
        }
      }
      emit(
        state.copyWith(
          researches: bookmarkedResearches,
          researchBookmarks: researchBookmarks,
        ),
      );
    });
  }

  final BookmarksRepo _bookmarkRepo;
  late final StreamSubscription<List<Bookmark>> _researchBookmarksSubscription;
  final ResearchesRepo _researchRepo;

  void onSelectionToggled(Research research) {
    final selectedResearch = [...state.selectedResearches];
    // Add if not exist or Remove if exist.
    selectedResearch.contains(research)
        ? selectedResearch.remove(research)
        : selectedResearch.add(research);
    emit(
      state.copyWith(
        status: BookmarksResearchesStatus.selecting,
        selectedResearches: selectedResearch,
      ),
    );
  }

  Future<void> onRemoved() async {
    emit(state.copyWith(status: BookmarksResearchesStatus.loading));
    final selectedResearches = [...state.selectedResearches];
    for (final research in state.selectedResearches) {
      final paper = (type: PaperType.research, id: research.id);
      await _bookmarkRepo.removeBookmark(paper).then((value) {
        selectedResearches.remove(research);
      });
    }
    // checking length if removed any item.
    selectedResearches.length < state.selectedResearches.length
        ? emit(
            state.copyWith(
              status: BookmarksResearchesStatus.success,
              selectedResearches: selectedResearches,
            ),
          )
        : emit(state.copyWith(status: BookmarksResearchesStatus.failure));
  }

  void onAllSelected() {
    emit(
      state.copyWith(
        status: BookmarksResearchesStatus.selecting,
        selectedResearches: state.researches,
      ),
    );
  }

  void onAllDeselected() {
    emit(
      state.copyWith(
        status: BookmarksResearchesStatus.initial,
        selectedResearches: const [],
      ),
    );
  }

  @override
  Future<void> close() {
    _researchBookmarksSubscription.cancel();
    return super.close();
  }
}
