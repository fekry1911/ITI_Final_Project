import 'package:iti_moqaf/core/networking/api_service.dart';

import '../../../../core/networking/api_result.dart';
import '../../../community/data/model/post_model.dart';

class GetAllPostsOfUserRepo {
  ApiService apiService;

  GetAllPostsOfUserRepo(this.apiService);

  Future<ApiResult<List<PostModel>>> getAllPostsOfUser(String id ) async =>
      apiService.getAllPostsOfUser(id: id);
}
