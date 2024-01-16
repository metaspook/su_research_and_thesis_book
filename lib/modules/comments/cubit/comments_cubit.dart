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
    //-- Initialize Comments subscription.
    _commentsSubscription = _commentRepo.stream.listen(_onComments);
  }

  final NotificationsRepo _notificationRepo;
  final CommentsRepo _commentRepo;
  late final StreamSubscription<List<Comment>> _commentsSubscription;

  Future<void> _onComments(List<Comment> comments) async {
    // process notification if new data.
    if (state.notify) {
      final record = AppNotification(
        type: NotificationType.comments,
        paper: comments.last.paper,
        userName: comments.last.author,
      );
      await _notificationRepo.add(record);
    }
    final notify = state.notify ? null : true;
    emit(
      state.copyWith(
        notify: notify,
        status: CommentsStatus.success,
        comments: comments,
      ),
    );
  }

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
          statusMsg: 'Success! Send comment.',
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
