import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'thesis_new_entry_state.dart';

class ThesisNewEntryCubit extends Cubit<ThesisNewEntryState> {
  ThesisNewEntryCubit({required ThesesRepo thesesRepo})
      : _thesisRepo = thesesRepo,
        super(const ThesisNewEntryState());

  final ThesesRepo _thesisRepo;

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
    final pickRecord = await _thesisRepo.pickToPath();
    if (pickRecord.errorMsg == null) {
      emit(state.copyWith(pdfPath: pickRecord.path));
    } else {
      emit(
        state.copyWith(
          status: ThesisNewEntryStatus.failure,
          statusMsg: pickRecord.errorMsg,
        ),
      );
    }
  }

  Future<void> upload({required String userId}) async {
    emit(state.copyWith(status: ThesisNewEntryStatus.loading));
    // Upload thesis file to storage.
    final uploadRecord = await _thesisRepo.uploadFile(state.pdfPath);
    if (uploadRecord.errorMsg == null) {
      final thesisId = _thesisRepo.newId;
      final thesisObj = {
        'userId': userId,
        'createdAt': timestamp,
        'departmentIndex': state.departmentIndex,
        'description': state.description,
        'title': state.title,
        'views': 0,
        'fileUrl': uploadRecord.fileUrl,
      };
      // Create thesis data in database.
      final errorMsg = await _thesisRepo.create(thesisId, value: thesisObj);
      if (errorMsg == null) {
        emit(
          const ThesisNewEntryState().copyWith(
            status: ThesisNewEntryStatus.success,
            statusMsg: 'Success! Thesis uploaded.',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ThesisNewEntryStatus.failure,
            statusMsg: errorMsg,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: ThesisNewEntryStatus.failure,
          statusMsg: uploadRecord.errorMsg,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _thesisRepo.clearTemp();
    return super.close();
  }
}
