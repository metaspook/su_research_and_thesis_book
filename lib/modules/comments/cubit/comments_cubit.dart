import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/repositories/repositories.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required NotificationsRepo notificationsRepo,
    required CommentsRepo commentsRepo,
  })  : _notificationRepo = notificationsRepo,
        _commentRepo = commentsRepo,
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

  final NotificationsRepo _notificationRepo;
  final CommentsRepo _commentRepo;
  late final StreamSubscription<List<Comment>> _commentsSubscription;

  Future<void> send({
    required String userId,
    required String paperId,
    required String commentStr,
  }) async {
    emit(state.copyWith(status: CommentsStatus.loading));
    // Upload thesis file to storage.
    final commentId = _commentRepo.newId;
    final commentObj = {
      'parentId': paperId,
      'userId': userId,
      'createdAt': timestamp,
      'content': commentStr.trim(),
    };
    // Create thesis data in database.
    final errorMsg = await _commentRepo.create(commentId, value: commentObj);
    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: CommentsStatus.success,
          statusMsg: 'Success! Comment sended.',
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
