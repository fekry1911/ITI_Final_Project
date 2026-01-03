import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/networking/api_result.dart';
import '../data/model/like_resonse_model.dart';
import '../data/repo/like_post_repo.dart';
part 'like_post_state.dart';
class LikePostCubit extends Cubit<LikePostState> {
  final LikePostRepo likePostRepo;

  LikePostCubit(this.likePostRepo) : super(LikePostInitial());

  Future<void> likePost({
    required String postId,
    required bool currentIsLiked,
    required int currentLikes,
  }) async {

    emit(
      LikePostLoading(
        postId: postId,
        isLiked: !currentIsLiked,
        likesCount:
        currentIsLiked ? currentLikes - 1 : currentLikes + 1,
      ),
    );

    final result = await likePostRepo.likePost(postId);

    if (result is ApiSuccess<LikeResponseModel>) {
      emit(
        LikePostSuccess(
          postId: postId,
          isLiked: !currentIsLiked,
          likesCount:
          currentIsLiked ? currentLikes - 1 : currentLikes + 1,
        ),
      );
    }

    if (result is ApiError<LikeResponseModel>) {
      emit(
        LikePostError(postId, result.message),
      );
    }
  }

}
