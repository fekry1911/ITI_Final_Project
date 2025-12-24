part of 'like_post_cubit.dart';


class LikePostState extends Equatable {
  const LikePostState();

  @override
  List<Object?> get props => [];
}

class LikePostInitial extends LikePostState {}

class LikePostLoading extends LikePostState {
  final String postId;
  final bool isLiked;
  final int likesCount;

  const LikePostLoading({
    required this.postId,
    required this.isLiked,
    required this.likesCount,
  });

  @override
  List<Object?> get props => [postId, isLiked, likesCount];
}

class LikePostSuccess extends LikePostState {
  final String postId;
  final bool isLiked;
  final int likesCount;

  const LikePostSuccess({
    required this.postId,
    required this.isLiked,
    required this.likesCount,
  });

  @override
  List<Object?> get props => [postId, isLiked, likesCount];
}

class LikePostError extends LikePostState {
  final String postId;
  final String message;

  const LikePostError(this.postId, this.message);

  @override
  List<Object?> get props => [postId, message];
}
