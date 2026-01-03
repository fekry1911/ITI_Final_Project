import '../models/comments_response_model.dart';
import '../networking/api_result.dart';
import '../networking/api_service.dart';

class GetAllCommentsOfPost{
  ApiService apiService;
  GetAllCommentsOfPost(this.apiService);
  Future<ApiResult<List<CommentModel>>> getAllCommentsOfPostRepo(id) async =>apiService.getAllCommentsOfPost(id: id);
}
