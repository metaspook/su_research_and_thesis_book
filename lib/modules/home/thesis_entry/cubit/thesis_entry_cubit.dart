import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/utils/extensions.dart';

part 'thesis_entry_state.dart';

class ThesisEntryCubit extends Cubit<ThesisEntryState> {
  ThesisEntryCubit() : super(const ThesisEntryState());

  void onChangedThesisName(String value) {
    value.doPrint();
  }
}
