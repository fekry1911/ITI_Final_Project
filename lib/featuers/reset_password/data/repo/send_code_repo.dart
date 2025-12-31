import 'package:iti_moqaf/core/networking/api_service.dart';

import '../../../../core/networking/api_result.dart';

class SendCodeOfVerificationRepo{
  ApiService apiService;

  SendCodeOfVerificationRepo(this.apiService);

  Future<ApiResult<String>> sendVerificationCode({
    required String email,
  }) async => apiService.sendVerificationCode(email: email);
}