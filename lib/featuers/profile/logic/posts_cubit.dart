import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/profile/data/repo/get_all_posts_repo.dart';
import 'package:meta/meta.dart';

import '../../community/data/model/post_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPostsOfUserRepo getAllPostsOfUserRepo;
  PostsCubit(this.getAllPostsOfUserRepo) : super(PostsInitial());

  List<PostModel> posts = [];
  bool isFetching = false;
  bool hasMore = true;
  int page = 1;
  int lastPage = 0;
  void addNewPost(PostModel newPost) {
    if (state is PostsLoaded) {
      final currentPosts = (state as PostsLoaded).posts;
      emit(PostsLoaded([newPost, ...currentPosts],hasMore));
    } else {
      emit(PostsLoaded([newPost],hasMore));
    }
  }

  Future<void> getAllPostsOfUser(String id) async {
    if (isFetching || !hasMore) return;
    isFetching = true;

    if (page == 1) {
      emit(PostsLoading());
    }
    final result = await getAllPostsOfUserRepo.getAllPostsOfUser(id,page: page);
    if (result is ApiSuccess<PostsResponse>) {
      lastPage = result.data.lastPage;
      final newPosts = result.data.data;
      if (newPosts.isEmpty) {
        hasMore = false;
      } else {
        page++;
        posts.addAll(newPosts);
      }
      emit(PostsLoaded(List.from(posts),hasMore));
    }

    else if (result is ApiError<PostsResponse>) {
      if (posts.isNotEmpty) {
        hasMore = false;
        emit(PostsLoaded(List.from(posts), hasMore));
      } else {
        emit(PostsError(result.message));
      }
    }
    isFetching = false;
  }
}
