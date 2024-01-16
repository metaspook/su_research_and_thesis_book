part of 'comments_cubit.dart';

enum CommentsStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == CommentsStatus.loading;
}

final class CommentsState extends Equatable {
  const CommentsState({
    this.status = CommentsStatus.initial,
    this.statusMsg,
    this.notify = false,
    this.comments,
  });

  final CommentsStatus status;
  final String? statusMsg;
  final bool notify;
  final List<Comment>? comments;

  CommentsState copyWith({
    CommentsStatus? status,
    String? statusMsg,
    bool? notify,
    List<Comment>? comments,
  }) {
    return CommentsState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      notify: notify ?? this.notify,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, notify, comments];
}
