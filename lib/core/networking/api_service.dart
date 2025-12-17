import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/const/api_const.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';

import '../../featuers/register/data/model/user_register_request.dart';

class ApiService {
  Dio dio;

  ApiService(this.dio);

  Future<ApiResult> registerUser(User user) async {
    try {
      var response = await dio.post(register, data: user.toJson());
      return ApiSuccess(response);
    } on DioException catch (e) {
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError(e.toString());
    }
  }
}
