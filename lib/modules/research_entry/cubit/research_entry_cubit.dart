import 'package:bloc/bloc.dart';

class ResearchEntryCubit extends Cubit<int> {
  ResearchEntryCubit() : super(0);

  void setView(int index) => emit(index);
}
