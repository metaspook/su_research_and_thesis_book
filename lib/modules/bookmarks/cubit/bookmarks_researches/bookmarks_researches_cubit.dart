import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'bookmarks_researches_state.dart';

class BookmarksResearchesCubit extends Cubit<BookmarksResearchesState> {
  BookmarksResearchesCubit({
    required ResearchRepo researchRepo,
    required BookmarkRepo bookmarkRepo,
  })  : _bookmarkRepo = bookmarkRepo,
        _researchRepo = researchRepo,
        super(const BookmarksResearchesState()) {
    // Initialize Research Bookmark subscription.
    _researchIdsSubscription =
        _bookmarkRepo.ids(PaperType.research).listen((researchIds) async {
      //-- Parse bookmarked researches.
      final bookmarkedResearch = await _researchRepo.stream.first.then(
        (researches) =>
            researches.where((e) => researchIds.contains(e.id)).toList(),
      );
      emit(state.copyWith(researches: bookmarkedResearch));
    });
  }

  final BookmarkRepo _bookmarkRepo;
  late final StreamSubscription<List<String>> _researchIdsSubscription;
  final ResearchRepo _researchRepo;

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

  void onRemoved() {
    final selectedResearches = [...state.selectedResearches];
    final researches = [...state.researches!]
      ..removeWhere(selectedResearches.remove);
    emit(
      state.copyWith(
        researches: researches,
        selectedResearches: selectedResearches,
      ),
    );
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

  void onAllRemoved() {
    emit(
      state.copyWith(
        status: BookmarksResearchesStatus.initial,
        researches: const [],
        selectedResearches: const [],
      ),
    );
  }

  @override
  Future<void> close() {
    _researchIdsSubscription.cancel();
    return super.close();
  }
}
