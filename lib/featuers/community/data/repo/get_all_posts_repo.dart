

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../model/post_model.dart';

class GetAllPostsRepo {
  ApiService apiService;

  GetAllPostsRepo(this.apiService);

  Future<ApiResult<PostsResponse>> getAllPostsRepo({required int page}) async =>
      await apiService.getAllPosts(page: page);
}
