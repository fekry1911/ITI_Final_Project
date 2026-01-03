import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class VerifyCodeOfVerification{

  ApiService apiService;
  VerifyCodeOfVerification(this.apiService);

  Future<ApiResult<String>> verifyOfVerificationCode({
    required String code,
  }) async => apiService.verifyVerificationCode(code: code);
}