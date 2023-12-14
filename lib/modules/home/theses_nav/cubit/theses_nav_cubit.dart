import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theses_nav_state.dart';

class ThesesNavCubit extends Cubit<ThesesNavState> {
  ThesesNavCubit() : super(const ThesesNavState());

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
