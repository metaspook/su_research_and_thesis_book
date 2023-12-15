import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'research_entry_state.dart';

class ResearchEntryCubit extends Cubit<ResearchEntryState> {
  ResearchEntryCubit({required ResearchRepo researchRepo})
      : _researchRepo = researchRepo,
        super(const ResearchEntryState());

  final ResearchRepo _researchRepo;

  void onChangedResearchName(String value) {
    emit(state.copyWith(researchName: value));
  }

  Future<void> pick() async {
    final pickRecord = await _researchRepo.pickToPath();
    if (pickRecord.errorMsg == null) {
      emit(state.copyWith(pdfPath: pickRecord.path));
    } else {
      emit(
        state.copyWith(
          status: ResearchEntryStatus.failure,
          statusMsg: pickRecord.errorMsg,
        ),
      );
    }
  }

  Future<void> upload({required String userId}) async {
    emit(state.copyWith(status: ResearchEntryStatus.loading));
    // Upload research file to storage.
    final uploadRecord = await _researchRepo.uploadFile(state.pdfPath);
    if (uploadRecord.errorMsg == null) {
      final researchId = _researchRepo.newId;
      final researchObj = {
        'userId': userId,
        'createdAt': timestamp,
        'name': state.researchName,
        'views': 0,
        'fileUrl': uploadRecord.fileUrl,
      };
      // Create research data in database.
      final errorMsg =
          await _researchRepo.create(researchId, value: researchObj);
      if (errorMsg == null) {
        emit(
          state.copyWith(
            status: ResearchEntryStatus.success,
            statusMsg: 'Success! Research uploaded.',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ResearchEntryStatus.failure,
            statusMsg: errorMsg,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: ResearchEntryStatus.failure,
          statusMsg: uploadRecord.errorMsg,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _researchRepo.clearTemp();
    return super.close();
  }
}
