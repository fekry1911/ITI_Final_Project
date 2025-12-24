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

  void addNewPost(PostModel newPost) {
    if (state is PostsLoaded) {
      final currentPosts = (state as PostsLoaded).posts;
      emit(PostsLoaded([newPost, ...currentPosts]));
    } else {
      emit(PostsLoaded([newPost]));
    }
  }

  Future<void> getAllPostsOfUser(String id) async {
    emit(PostsLoading());
    final result = await getAllPostsOfUserRepo.getAllPostsOfUser(id);
    if(result is ApiSuccess<List<PostModel>>){
      emit(PostsLoaded(result.data));
    }else if(result is ApiError<List<PostModel>>){
      emit(PostsError(result.message));
    }
  }
}
