import 'package:dio/dio.dart';

import '../helpers/cach_helper.dart';

class AppInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = CacheHelper.getString(key: "token");
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    print('➡️ REQUEST');
    print('${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE');
    print('Status: ${response.statusCode}');
    print('Path: ${response.requestOptions.path}');
    print('Data: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR');
    print('Message: ${err.message}');
    print('Status: ${err.response?.statusCode}');
    print('Path: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
