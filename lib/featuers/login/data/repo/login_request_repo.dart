
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/user_login_request.dart';
import '../models/user_login_response.dart';

class LoginRequestRepo {
  ApiService apiService;
  LoginRequestRepo(this.apiService);

  Future<ApiResult<UserLoginResponse>> loginUser(UserLoginRequest user) async =>
      apiService.loginUser(user);
}
