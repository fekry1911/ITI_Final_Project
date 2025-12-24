import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';

import '../models/comments_response_model.dart';

class GetAllCommentsOfPost{
  ApiService apiService;
  GetAllCommentsOfPost(this.apiService);
  Future<ApiResult<List<CommentModel>>> getAllCommentsOfPostRepo(id) async =>apiService.getAllCommentsOfPost(id: id);
}
