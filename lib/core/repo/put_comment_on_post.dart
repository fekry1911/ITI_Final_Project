import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';

import '../models/comments_response_model.dart';
import '../networking/api_result.dart';

class PutCommentOnPost{
  ApiService apiService;
  PutCommentOnPost(this.apiService);
  Future<ApiResult<CommentModel>> commentOnPostRepo(id,content) async =>apiService.commentOnPost(id,content);
}