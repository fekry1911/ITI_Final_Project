import 'package:iti_moqaf/core/networking/api_service.dart';

import '../../../../core/networking/api_result.dart';

class VerifyCodeOfVerification{

  ApiService apiService;
  VerifyCodeOfVerification(this.apiService);

  Future<ApiResult<String>> verifyOfVerificationCode({
    required String code,
  }) async => apiService.verifyVerificationCode(code: code);
}