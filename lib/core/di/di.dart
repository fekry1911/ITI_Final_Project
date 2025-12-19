import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';
import 'package:iti_moqaf/core/networking/dio_config.dart';
import 'package:iti_moqaf/featuers/login/data/repo/login_request_repo.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';
import 'package:iti_moqaf/featuers/register/logic/register_user_cubit.dart';

import '../../featuers/register/data/repo/register_user.dart';

final getIt = GetIt.instance;
void configureDependencies() {
  Dio dio = DioConfig.instance.dio;
  getIt.registerLazySingleton<Dio>(() => dio);
  // api service
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  //repos
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<LoginRequestRepo>(
    () => LoginRequestRepo(getIt<ApiService>()),
  );

  // cubit
  getIt.registerFactory<RegisterUserCubit>(
    () => RegisterUserCubit(getIt<RegisterUser>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit((getIt<LoginRequestRepo>())),
  );
}
