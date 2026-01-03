import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class SendCodeOfVerificationRepo{
  ApiService apiService;

  SendCodeOfVerificationRepo(this.apiService);

  Future<ApiResult<String>> sendVerificationCode({
    required String email,
  }) async => apiService.sendVerificationCode(email: email);
}