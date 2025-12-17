import 'package:iti_moqaf/core/networking/api_service.dart';

import '../../../../core/networking/api_result.dart';
import '../model/user_register_request.dart';

class RegisterUser{
  ApiService apiService;
  RegisterUser(this.apiService);

  Future<ApiResult> registerUser(User user) async => apiService.registerUser(user);
}