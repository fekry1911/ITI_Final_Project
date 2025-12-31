import 'package:iti_moqaf/core/networking/api_service.dart';

import '../../../../core/networking/api_result.dart';

class ResetPasswordRepo {
  ApiService apiService;

  ResetPasswordRepo(this.apiService);

  Future<ApiResult<String>> handleResetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async => await apiService.resetNewPassword(
    newPassword: newPassword,
    confirmPassword: confirmPassword,
    token: token,
  );
}
