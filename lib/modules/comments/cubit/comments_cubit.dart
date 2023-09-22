import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({required CommentRepo commentRepo})
      : _commentRepo = commentRepo,
        super(const CommentsState()) {
    //-- Comments data subscription.
    emit(state.copyWith(status: CommentsStatus.loading));
    _commentsSubscription = _commentRepo.stream.listen((comments) async {
      if (comments.isNotEmpty) {
        emit(
          state.copyWith(status: CommentsStatus.success, comments: comments),
        );
      }
    });
  }

  final CommentRepo _commentRepo;
  late final StreamSubscription<List<Comment>> _commentsSubscription;

  void onChangedCommentText(String value) {
    value.doPrint();
    emit(state.copyWith(commentText: value));
  }

  Future<void> send({
    required String userId,
    required String thesisId,
  }) async {
    emit(state.copyWith(status: CommentsStatus.loading));
    // Upload thesis file to storage.
    final commentId = _commentRepo.newId;
    final commentObj = {
      'thesisId': thesisId,
      'userId': userId,
      'createdAt': timestamp,
      'content': state.commentText.trim(),
    };
    // Create thesis data in database.
    final errorMsg = await _commentRepo.create(commentId, value: commentObj);
    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: CommentsStatus.success,
          statusMsg: 'Success! Thesis uploaded.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CommentsStatus.failure,
          statusMsg: errorMsg,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _commentsSubscription.cancel();
    return super.close();
  }
}
