part of 'create_post_cubit.dart';

@immutable
sealed class CreatePostState extends Equatable {}

final class CreatePostInitial extends CreatePostState {
  @override
  List<Object?> get props => [];
}

final class CreatePostContentChanged extends CreatePostState {
  final bool canPost;
  CreatePostContentChanged(this.canPost);

  @override
  List<Object?> get props => [canPost];
}

final class CreatePostLoading extends CreatePostState {
  @override
  List<Object?> get props => [];
}

final class CreatePostSuccess extends CreatePostState {
  final PostModel postModel;
  CreatePostSuccess(this.postModel);

  @override
  List<Object?> get props => [postModel];
}

final class CreatePostError extends CreatePostState {
  final String error;
  CreatePostError(this.error);

  @override
  List<Object?> get props => [error];
}

final class CreatePostImagePicked extends CreatePostState {
  @override
  List<Object?> get props => [];
}

final class CreatePostImageRemoved extends CreatePostState {
  @override
  List<Object?> get props => [];
}

final class CreatePostTypeChanged extends CreatePostState {
  final String type;
  CreatePostTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}