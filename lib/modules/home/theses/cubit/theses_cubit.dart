import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theses_state.dart';

class ThesesCubit extends Cubit<ThesesState> {
  ThesesCubit() : super(const ThesesState());

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
