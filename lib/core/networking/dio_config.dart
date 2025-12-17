import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/const/api_const.dart';

class DioConfig {
  // https://auth-api-2-jz52.onrender.com

  DioConfig._();
  static DioConfig instance = DioConfig._();

  Dio dio = Dio()
    ..options.baseUrl = apiBaseURL
    ..options.connectTimeout = const Duration(seconds: 190)
    ..options.receiveTimeout = const Duration(seconds: 10);
}
