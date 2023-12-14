import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'researches_nav_state.dart';

class ResearchesNavCubit extends Cubit<ResearchesNavState> {
  ResearchesNavCubit({
    required AppUserRepo appUserRepo,
    required ResearchRepo researchRepo,
    required CategoryRepo categoryRepo,
  })  : _appUserRepo = appUserRepo,
        _researchRepo = researchRepo,
        _categoryRepo = categoryRepo,
        super(const ResearchesNavState()) {
    //-- Initialize categories.
    emit(state.copyWith(status: ResearchesNavStatus.loading));
    _categoryRepo.categories.then(
      (categoriesRecord) => emit(
        state.copyWith(
          status: ResearchesNavStatus.success,
          categories: categoriesRecord.categories,
        ),
      ),
    );
  }

  final AppUserRepo _appUserRepo;
  final ResearchRepo _researchRepo;
  final CategoryRepo _categoryRepo;

  void toggleSearch() {
    emit(state.copyWith(searchMode: !state.searchMode, search: ''));
  }

  void onChangedSearch(String value) {
    emit(state.copyWith(search: value));
  }

  void onChangedCategory(String? value) {
    emit(state.copyWith(category: value));
  }
}
