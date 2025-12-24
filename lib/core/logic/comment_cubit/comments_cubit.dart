import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/models/comments_response_model.dart';
import 'package:iti_moqaf/core/repo/get_all_comments_post.dart';
import 'package:iti_moqaf/core/repo/put_comment_on_post.dart';
import 'package:meta/meta.dart';

import '../../networking/api_result.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final GetAllCommentsOfPost getAllCommentsOfPost;
  final PutCommentOnPost putCommentOnPost;

  CommentsCubit(this.getAllCommentsOfPost, this.putCommentOnPost) : super(const CommentsState());

  Future<void> getComments(String postId) async {
    emit(state.copyWith(status: CommentsStatus.loading));
    var result = await getAllCommentsOfPost.getAllCommentsOfPostRepo(postId);
    if (result is ApiSuccess<List<CommentModel>>) {
      emit(state.copyWith(
        status: CommentsStatus.success,
        comments: result.data,
      ));
    } else if (result is ApiError<List<CommentModel>>) {
      emit(state.copyWith(
        status: CommentsStatus.error,
        error: result.message,
      ));
    }
  }

  Future<void> addComment(String postId, String content) async {
    emit(state.copyWith(status: CommentsStatus.adding));
    var result = await putCommentOnPost.commentOnPostRepo(postId, content);
    
    if (result is ApiSuccess<CommentModel>) {
      final newComment = result.data;
      final updatedList = [newComment, ...state.comments];
      
      emit(state.copyWith(
        status: CommentsStatus.addSuccess,
        comments: updatedList,
      ));
      
      // Reset status to success to allow subsequent additions and keep UI clean
      emit(state.copyWith(status: CommentsStatus.success));
    } else if (result is ApiError<CommentModel>) {
      emit(state.copyWith(
        status: CommentsStatus.addError,
        error: result.message,
      ));
    }
  }

}
