import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'thesis_entry_state.dart';

class ThesisEntryCubit extends Cubit<ThesisEntryState> {
  ThesisEntryCubit({required ThesisRepo thesisRepo})
      : _thesisRepo = thesisRepo,
        super(const ThesisEntryState());

  final ThesisRepo _thesisRepo;

  void onChangedThesisName(String value) {
    emit(state.copyWith(thesisName: value));
  }

  Future<void> pickPdf() async {
    final pdfPath = await _thesisRepo.pickedPdfPath();
    emit(state.copyWith(pdfPath: pdfPath));
  }

  @override
  Future<void> close() {
    _thesisRepo.clearTempFiles();
    return super.close();
  }
}
