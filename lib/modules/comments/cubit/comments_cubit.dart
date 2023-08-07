import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/shared.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(const CommentsState());
}
