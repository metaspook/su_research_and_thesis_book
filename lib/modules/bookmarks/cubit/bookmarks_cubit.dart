import 'package:bloc/bloc.dart';

class BookmarksCubit extends Cubit<int> {
  BookmarksCubit() : super(0);

  void getViewIndex(int index) => emit(index);
}
