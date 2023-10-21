import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'theses_state.dart';

class ThesesCubit extends Cubit<ThesesState> {
  ThesesCubit({
    required AppUserRepo appUserRepo,
    required ThesisRepo thesisRepo,
  })  : _appUserRepo = appUserRepo,
        _thesisRepo = thesisRepo,
        super(const ThesesState()) {
    //-- Initialize departments.
    emit(state.copyWith(status: ThesesStatus.loading));
    _appUserRepo.departments.then(
      (departmentsRecord) => emit(
        state.copyWith(
          status: ThesesStatus.success,
          departments: departmentsRecord.departments,
        ),
      ),
    );
  }

  final AppUserRepo _appUserRepo;
  final ThesisRepo _thesisRepo;

  void toggleSearch() {
    emit(state.copyWith(searchMode: !state.searchMode, search: ''));
  }

  void onChangedSearch(String value) {
    emit(state.copyWith(search: value));
  }

  void onChangedDepartment(String? value) {
    emit(state.copyWith(department: value));
  }
}
