part of 'get_all_posts_cubit.dart';

@immutable
sealed class GetAllPostsState extends Equatable {}

final class GetAllPostsInitial extends GetAllPostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllPostsLoading extends GetAllPostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllPostsSuccess extends GetAllPostsState {
  final List<PostModel> postModel;

  GetAllPostsSuccess(this.postModel);

  @override
  // TODO: implement props
  List<Object?> get props => [postModel];
}

final class GetAllPostsError extends GetAllPostsState {
  final String message;

  GetAllPostsError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
