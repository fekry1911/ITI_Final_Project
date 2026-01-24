import 'package:dio/dio.dart';

import '../helpers/cach_helper.dart';

class AppPathInterceptor extends Interceptor {
  static const apiKey = 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjY1Y2MyY2U1N2QwMTRkY2RiMGUzNWM1MTNlYzRiYTM4IiwiaCI6Im11cm11cjY0In0=';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      options.headers['Authorization'] = 'Bearer $apiKey';
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
