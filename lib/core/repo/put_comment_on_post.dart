import '../models/comments_response_model.dart';
import '../networking/api_result.dart';
import '../networking/api_service.dart';

class PutCommentOnPost{
  ApiService apiService;
  PutCommentOnPost(this.apiService);
  Future<ApiResult<CommentModel>> commentOnPostRepo(id,content) async =>apiService.commentOnPost(id,content);
}