import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'theses_state.dart';

class ThesesCubit extends Cubit<ThesesState> {
  ThesesCubit({required ThesisRepo thesisRepo})
      : _thesisRepo = thesisRepo,
        super(const ThesesState());

  final ThesisRepo _thesisRepo;

  void toggleSearch() {
    emit(state.copyWith(searchMode: !state.searchMode, search: ''));
  }

  void onChangedSearch(String value) {
    emit(state.copyWith(search: value));
  }
}
