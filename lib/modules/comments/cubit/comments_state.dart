part of 'comments_cubit.dart';

enum CommentsStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == CommentsStatus.loading;
  bool get hasMessage =>
      this == CommentsStatus.success || this == CommentsStatus.failure;
}

final class CommentsState extends Equatable {
  const CommentsState({
    this.status = CommentsStatus.initial,
    this.statusMsg = '',
    this.comments = const [],
    this.commentText = '',
  });

  final CommentsStatus status;
  final String statusMsg;
  final List<Comment> comments;
  final String commentText;

  CommentsState copyWith({
    CommentsStatus? status,
    String? statusMsg,
    List<Comment>? comments,
    String? commentText,
  }) {
    return CommentsState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      comments: comments ?? this.comments,
      commentText: commentText ?? this.commentText,
    );
  }

  @override
  List<Object> get props => [status, statusMsg, comments, commentText];
}
