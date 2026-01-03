import '../../../core/networking/api_result.dart';
import '../../../core/networking/api_service.dart';
import '../../community/data/model/post_model.dart';
import 'creatr_post_model.dart';

class CreatePostRepo {
  ApiService apiService;

  CreatePostRepo(this.apiService);

  Future<ApiResult<PostModel>> createPost(
    CreatePostModel createPostModel,
  ) async => apiService.createPost(createPostModel);
}
