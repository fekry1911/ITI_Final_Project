part of 'posts_cubit.dart';

@immutable
sealed class PostsState extends Equatable{}

final class PostsInitial extends PostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class PostsLoading extends PostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class PostsLoaded extends PostsState {
  final List<PostModel> posts;

  PostsLoaded(this.posts);

  @override
  // TODO: implement props
  List<Object?> get props => [posts];

}

final class PostsError extends PostsState {
  final String message;

  PostsError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];

}
