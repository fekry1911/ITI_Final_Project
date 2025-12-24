import 'package:iti_moqaf/core/networking/api_service.dart';

import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'package:iti_moqaf/featuers/create_post/data/creatr_post_model.dart';

class CreatePostRepo {
  ApiService apiService;

  CreatePostRepo(this.apiService);

  Future<ApiResult<PostModel>> createPost(
    CreatePostModel createPostModel,
  ) async => apiService.createPost(createPostModel);
}
