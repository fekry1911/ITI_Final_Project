import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'package:iti_moqaf/featuers/community/data/repo/like_post_repo.dart';
import 'package:meta/meta.dart';

import 'package:iti_moqaf/featuers/community/data/repo/get_all_posts_repo.dart';

part 'get_all_posts_state.dart';

class GetAllPostsCubit extends Cubit<GetAllPostsState> {
  final GetAllPostsRepo getAllPostsRepo;
  GetAllPostsCubit(this.getAllPostsRepo) : super(GetAllPostsInitial());

  Future<void> getAllPosts() async {
    emit(GetAllPostsLoading());
    final result = await getAllPostsRepo.getAllPostsRepo();
    if(result is ApiSuccess<List<PostModel>>){
      emit(GetAllPostsSuccess(result.data));
    }
    if(result is ApiError<List<PostModel>>){
      emit(GetAllPostsError(result.message));
    }
  }

  void updatePostLocal(String postId, {int? likesCount, bool? isLiked, int? commentsCount}) {
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
      emit(GetAllPostsSuccess(updatedPosts));
    }
  }

  void addNewPost(PostModel newPost) {
    print("GetAllPostsCubit(${identityHashCode(this)}): Adding new post locally.");
    if (state is GetAllPostsSuccess) {
      final currentPosts = (state as GetAllPostsSuccess).postModel;
      final updatedPosts = [newPost, ...currentPosts];
      emit(GetAllPostsSuccess(updatedPosts));
    } else {
      emit(GetAllPostsSuccess([newPost]));
    }
  }
}
