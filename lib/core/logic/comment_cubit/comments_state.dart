part of 'comments_cubit.dart';

enum CommentsStatus {
  initial,
  loading,
  success,
  error,
  adding,
  addSuccess,
  addError
}

final class CommentsState extends Equatable {
  final List<CommentModel> comments;
  final CommentsStatus status;
  final String? error;

  const CommentsState({
    this.comments = const [],
    this.status = CommentsStatus.initial,
    this.error,
  });

  CommentsState copyWith({
    List<CommentModel>? comments,
    CommentsStatus? status,
    String? error,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [comments, status, error];
}
