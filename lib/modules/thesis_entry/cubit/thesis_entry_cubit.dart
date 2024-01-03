import 'package:bloc/bloc.dart';

class ThesisEntryCubit extends Cubit<int> {
  ThesisEntryCubit() : super(0);

  void setView(int index) => emit(index);
}
