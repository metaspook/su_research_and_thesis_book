import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'thesis_entries_state.dart';

class ThesisEntriesCubit extends Cubit<ThesisEntriesState> {
  ThesisEntriesCubit({required ThesesRepo thesesRepo})
      : _thesisRepo = thesesRepo,
        super(const ThesisEntriesState());

  final ThesesRepo _thesisRepo;

  void onSelectionToggled(Thesis thesis) {
    final selectedThesis = [...state.selectedTheses];
    // Add if not exist or Remove if exist.
    selectedThesis.contains(thesis)
        ? selectedThesis.remove(thesis)
        : selectedThesis.add(thesis);
    emit(
      state.copyWith(
        status: ThesisEntriesStatus.selecting,
        selectedTheses: selectedThesis,
      ),
    );
  }

  Future<void> onRemoved() async {
    emit(state.copyWith(status: ThesisEntriesStatus.loading));
    final selectedTheses = [...state.selectedTheses];
    String? errorMsg;
    for (final thesis in state.selectedTheses) {
      errorMsg = await _thesisRepo.delete(thesis.id);
      selectedTheses.remove(thesis);
    }
    // checking length if removed any item.
    selectedTheses.length < state.selectedTheses.length
        ? emit(
            state.copyWith(
              status: ThesisEntriesStatus.success,
              selectedTheses: selectedTheses,
            ),
          )
        : emit(
            state.copyWith(
              status: ThesisEntriesStatus.failure,
              statusMsg: errorMsg,
            ),
          );
  }

  void onAllSelected(List<Thesis> theses) {
    emit(
      state.copyWith(
        status: ThesisEntriesStatus.selecting,
        selectedTheses: theses,
      ),
    );
  }

  void onAllDeselected() {
    emit(
      state.copyWith(
        status: ThesisEntriesStatus.initial,
        selectedTheses: const [],
      ),
    );
  }
}
