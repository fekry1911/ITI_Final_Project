import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../../community/data/model/post_model.dart';

class GetAllPostsOfUserRepo {
  ApiService apiService;

  GetAllPostsOfUserRepo(this.apiService);

  Future<ApiResult<PostsResponse>> getAllPostsOfUser(String id,{required int page} ) async =>
      apiService.getAllPostsOfUser(id: id,page: page);
}
