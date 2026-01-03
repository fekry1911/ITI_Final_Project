import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../all_chats_response.dart';

class GetAllChatsRepo{
  ApiService apiService;
  GetAllChatsRepo(this.apiService);
  Future<ApiResult<ChatResponse>> getAllChats(String id) async {
    return await apiService.getAllChats(id);
  }
}