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
  final bool hasMore;
  final bool isLoadingMore; // Added

  GetAllPostsSuccess(this.postModel, this.hasMore, {this.isLoadingMore = false});

  @override
  // TODO: implement props
  List<Object?> get props => [postModel, hasMore, isLoadingMore];
}

final class GetAllPostsError extends GetAllPostsState {
  final String message;

  GetAllPostsError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
