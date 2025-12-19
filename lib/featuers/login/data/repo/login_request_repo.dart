import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_request.dart';

class LoginRequestRepo {
  ApiService apiService;
  LoginRequestRepo(this.apiService);

  Future<ApiResult> loginUser(UserLoginRequest user) async =>
      apiService.loginUser(user);
}
