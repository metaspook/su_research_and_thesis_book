import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'research_entries_state.dart';

class ResearchEntriesCubit extends Cubit<ResearchEntriesState> {
  ResearchEntriesCubit({required ResearchesRepo researchesRepo})
      : _researchRepo = researchesRepo,
        super(const ResearchEntriesState());

  final ResearchesRepo _researchRepo;

  void onSelectionToggled(Research research) {
    final selectedResearch = [...state.selectedResearches];
    // Add if not exist or Remove if exist.
    selectedResearch.contains(research)
        ? selectedResearch.remove(research)
        : selectedResearch.add(research);
    emit(
      state.copyWith(
        status: ResearchEntriesStatus.selecting,
        selectedResearches: selectedResearch,
      ),
    );
  }

  Future<void> onRemoved() async {
    emit(state.copyWith(status: ResearchEntriesStatus.loading));
    final selectedResearches = [...state.selectedResearches];
    String? errorMsg;
    for (final research in state.selectedResearches) {
      errorMsg = await _researchRepo.delete(research.id);
      if (errorMsg != null) break;
      selectedResearches.remove(research);
    }
    // checking length if removed any item.
    selectedResearches.length < state.selectedResearches.length
        ? emit(
            state.copyWith(
              status: ResearchEntriesStatus.success,
              selectedResearches: selectedResearches,
            ),
          )
        : emit(
            state.copyWith(
              status: ResearchEntriesStatus.failure,
              statusMsg: errorMsg,
            ),
          );
  }

  void onAllSelected(List<Research> researches) {
    emit(
      state.copyWith(
        status: ResearchEntriesStatus.selecting,
        selectedResearches: researches,
      ),
    );
  }

  void onAllDeselected() {
    emit(
      state.copyWith(
        status: ResearchEntriesStatus.initial,
        selectedResearches: const [],
      ),
    );
  }
}
