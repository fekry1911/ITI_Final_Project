import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../model/like_resonse_model.dart';

class LikePostRepo{
  ApiService apiService;
  LikePostRepo(this.apiService);
  Future<ApiResult<LikeResponseModel>> likePost(id) async =>apiService.likePost(id);
}