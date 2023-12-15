import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'researches_nav_state.dart';

class ResearchesNavCubit extends Cubit<ResearchesNavState> {
  ResearchesNavCubit() : super(const ResearchesNavState());

  void toggleSearch() {
    emit(state.copyWith(searchMode: !state.searchMode, search: ''));
  }

  void onChangedSearch(String value) {
    emit(state.copyWith(status: ResearchesNavStatus.editing, search: value));
  }

  void onChangedCategory(String? value) {
    emit(state.copyWith(category: value));
  }
}
