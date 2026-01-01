import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:iti_moqaf/core/const/api_const.dart';
import 'package:path_provider/path_provider.dart'; // للوصول لمجلد الجهاز

import 'app_interceptor.dart';

class DioConfig {
  DioConfig._();

  static final DioConfig instance = DioConfig._();

  late Dio dio;
  late CacheOptions cacheOptions;
  late HiveCacheStore cacheStore;

  // تهيئة HiveCacheStore
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    cacheStore = HiveCacheStore('${dir.path}/dio_cache'); // مجلد تخزين الكاش

    cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      // يحصل من الشبكة ويحدث الكاش
      hitCacheOnErrorExcept: [401, 403],
      // لو حصل خطأ غير 401/403 يستخدم الكاش
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: (request) => request.uri.toString(),
    );

    dio =
        Dio(
            BaseOptions(
              validateStatus: (status) {
                return status != null && status < 400; // يقبل 304
              },
              baseUrl: apiBaseURL,
              connectTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
            ),
          )
          ..interceptors.add(AppInterceptor())
          ..interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }
}
