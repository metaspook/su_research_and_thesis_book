import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'research_new_entry_state.dart';

class ResearchNewEntryCubit extends Cubit<ResearchNewEntryState> {
  ResearchNewEntryCubit({required ResearchRepo researchRepo})
      : _researchRepo = researchRepo,
        super(const ResearchNewEntryState());

  final ResearchRepo _researchRepo;

  void onChangedTitle(String value) {
    emit(state.copyWith(title: value));
  }

  void onChangedDepartment(int? value) {
    emit(state.copyWith(departmentIndex: value));
  }

  void onChangedDescription(String? value) {
    emit(state.copyWith(description: value));
  }

  Future<void> pick() async {
    final pickRecord = await _researchRepo.pickToPath();
    if (pickRecord.errorMsg == null) {
      emit(state.copyWith(pdfPath: pickRecord.path));
    } else {
      emit(
        state.copyWith(
          status: ResearchNewEntryStatus.failure,
          statusMsg: pickRecord.errorMsg,
        ),
      );
    }
  }

  Future<void> upload({required String userId}) async {
    emit(state.copyWith(status: ResearchNewEntryStatus.loading));
    // Upload research file to storage.
    final uploadRecord = await _researchRepo.uploadFile(state.pdfPath);
    if (uploadRecord.errorMsg == null) {
      final researchId = _researchRepo.newId;
      final researchObj = {
        'userId': userId,
        'createdAt': timestamp,
        'departmentIndex': state.departmentIndex,
        'description': state.description,
        'title': state.title,
        'views': 0,
        'fileUrl': uploadRecord.fileUrl,
      };
      // Create research data in database.
      final errorMsg =
          await _researchRepo.create(researchId, value: researchObj);
      if (errorMsg == null) {
        emit(
          state.copyWith(
            status: ResearchNewEntryStatus.success,
            statusMsg: 'Success! Research uploaded.',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ResearchNewEntryStatus.failure,
            statusMsg: errorMsg,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: ResearchNewEntryStatus.failure,
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
