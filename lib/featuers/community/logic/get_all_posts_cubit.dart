import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/networking/api_result.dart';
import '../data/model/post_model.dart';
import '../data/repo/get_all_posts_repo.dart';

part 'get_all_posts_state.dart';

class GetAllPostsCubit extends Cubit<GetAllPostsState> {
  final GetAllPostsRepo getAllPostsRepo;

  GetAllPostsCubit(this.getAllPostsRepo) : super(GetAllPostsInitial());

  List<PostModel> posts = [];
  bool isFetching = false;
  bool hasMore = true;
  int page = 1;
  int lastPage = 0;

  Future<void> getAllPosts() async {
    print("pagin");
    if (isFetching || !hasMore) return;

    isFetching = true;

    if (page == 1) {
      emit(GetAllPostsLoading());
    }

    final result = await getAllPostsRepo.getAllPostsRepo(page: page);

    if (result is ApiSuccess<PostsResponse>) {
      lastPage = result.data.lastPage;
      final newPosts = result.data.data;

      if (newPosts.isEmpty) {
        hasMore = false;
      } else {
        page++;
        posts.addAll(newPosts);

      }


      emit(GetAllPostsSuccess(List.from(posts), hasMore));
    } else if (result is ApiError<PostsResponse>) {
      if (posts.isNotEmpty) {
        hasMore = false;
        emit(GetAllPostsSuccess(List.from(posts), hasMore));
      } else {
        emit(GetAllPostsError(result.message));
      }
    }

    isFetching = false;
  }

  void updatePostLocal(
    String postId, {
    int? likesCount,
    bool? isLiked,
    int? commentsCount,
  }) {
    if (state is GetAllPostsSuccess) {
      final currentPosts = (state as GetAllPostsSuccess).postModel;
      final updatedPosts = currentPosts.map((post) {
        if (post.id == postId) {
          return post.copyWith(
            likesCount: likesCount ?? post.likesCount,
            isLiked: isLiked ?? post.isLiked,
            commentsCount: commentsCount ?? post.commentsCount,
          );
        }
        return post;
      }).toList();
      emit(GetAllPostsSuccess(updatedPosts, hasMore));
    }
  }

  void addNewPost(PostModel newPost) {
    print(
      "GetAllPostsCubit(${identityHashCode(this)}): Adding new post locally.",
    );
    if (state is GetAllPostsSuccess) {
      final currentPosts = (state as GetAllPostsSuccess).postModel;
      final updatedPosts = [newPost, ...currentPosts];
      emit(GetAllPostsSuccess(updatedPosts, hasMore));
    } else {
      emit(GetAllPostsSuccess([newPost], hasMore));
    }
  }
}
