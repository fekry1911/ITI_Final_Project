import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/const/api_const.dart';

import 'app_interceptor.dart';

class DioConfig {
  // https://auth-api-2-jz52.onrender.com

  DioConfig._();
  static DioConfig instance = DioConfig._();

  Dio dio = Dio()
    ..options.baseUrl = apiBaseURL
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)..interceptors.add(AppInterceptor());


}