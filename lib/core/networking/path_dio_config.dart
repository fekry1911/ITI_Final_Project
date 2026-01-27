import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart'; // للوصول لمجلد الجهاز

import '../const/api_const.dart';
import 'app_interceptor.dart';
import 'app_path_interceptor.dart';

class DioPathConfig {
  DioPathConfig._();

  static final DioPathConfig instance = DioPathConfig._();

  late Dio dio;
  Future<void> init() async {

    dio =
    Dio(
      BaseOptions(
        baseUrl: apiBasePathURL,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    )
      ..interceptors.add(AppPathInterceptor());
  }
}
