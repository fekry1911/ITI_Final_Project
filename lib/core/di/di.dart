import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:iti_moqaf/core/networking/path_dio_config.dart';
import 'package:iti_moqaf/featuers/home/logic/home_cubit.dart';
import 'package:iti_moqaf/featuers/map/data/impl/get_route_impl.dart';

import '../../featuers/alllChats/data/repo/get_all_chats_repo.dart';
import '../../featuers/alllChats/logic/get_all_chats_cubit.dart';
import '../../featuers/chat/logic/chat_cubit.dart';
import '../../featuers/community/data/repo/get_all_posts_repo.dart';
import '../../featuers/community/data/repo/like_post_repo.dart';
import '../../featuers/community/logic/get_all_posts_cubit.dart';
import '../../featuers/community/logic/like_post_cubit.dart';
import '../../featuers/create_post/data/create_post_repo.dart';
import '../../featuers/create_post/logic/create_post_cubit.dart';
import '../../featuers/line_details/data/repo/book_cancel_repo.dart';
import '../../featuers/line_details/data/repo/check_out_payment.dart';
import '../../featuers/line_details/data/repo/get_line_details_repo.dart';
import '../../featuers/line_details/logic/get_details_of_line_cubit.dart';
import '../../featuers/line_details/logic/manage_book_seat_cubit.dart';
import '../../featuers/login/data/repo/login_request_repo.dart';
import '../../featuers/login/logic/login_cubit.dart';
import '../../featuers/map/data/source/service.dart';
import '../../featuers/map/domain/repo/get_route.dart';
import '../../featuers/map/presentation/logic/path_between_points_dart_cubit.dart';
import '../../featuers/near_stations/data/repo/get_nearby_stations.dart';
import '../../featuers/near_stations/logic/get_nearby_stations_cubit.dart';
import '../../featuers/profile/data/repo/get_all_posts_repo.dart';
import '../../featuers/profile/data/repo/profile_repo.dart';
import '../../featuers/profile/logic/posts_cubit.dart';
import '../../featuers/profile/logic/profile_cubit.dart';
import '../../featuers/register/data/repo/register_user.dart';
import '../../featuers/register/logic/register_user_cubit.dart';
import '../../featuers/reset_password/data/repo/reset_password.dart';
import '../../featuers/reset_password/data/repo/send_code_repo.dart';
import '../../featuers/reset_password/data/repo/verify_code.dart';
import '../../featuers/reset_password/logic/reset_password_cubit.dart';
import '../../featuers/stations/data/model/repo/get_all_stations-repo.dart';
import '../../featuers/stations/logic/get_all_stations_cubit.dart';
import '../../featuers/stations_details/data/repo/get_one_station_repo.dart';
import '../../featuers/stations_details/logic/get_one_station_cubit.dart';
import '../logic/comment_cubit/comments_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_config.dart';
import '../networking/socket_service.dart';
import '../repo/get_all_comments_post.dart';
import '../repo/put_comment_on_post.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  Dio dio = DioConfig.instance.dio;
  Dio dioPath=DioPathConfig.instance.dio;

  getIt.registerLazySingleton<Dio>(() => dio,instanceName: "main");
  getIt.registerLazySingleton<Dio>(() => dioPath,instanceName: "path");

  // api service
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>(instanceName: "main")));
  getIt.registerLazySingleton<SocketService>(() => SocketService());
  getIt.registerLazySingleton<GetData>(() => GetData(getIt<Dio>(instanceName: "path")));


  //repos
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetRoute>(
        () => GetRouteImpl(getIt<GetData>()),
  );

  getIt.registerLazySingleton<GetAllStationsRepo>(
    () => GetAllStationsRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetNearbyStationsRepo>(
    () => GetNearbyStationsRepo(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<GetOneStationRepo>(
    () => GetOneStationRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<LoginRequestRepo>(
    () => LoginRequestRepo(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetLineDetailsRepo>(
    () => GetLineDetailsRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetAllPostsRepo>(
    () => GetAllPostsRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CreatePostRepo>(
    () => CreatePostRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<LikePostRepo>(
    () => LikePostRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetAllPostsOfUserRepo>(
    () => GetAllPostsOfUserRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetAllCommentsOfPost>(
    () => GetAllCommentsOfPost(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<PutCommentOnPost>(
    () => PutCommentOnPost(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetAllChatsRepo>(
    () => GetAllChatsRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<BookAndCancelRepo>(
    () => BookAndCancelRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CheckOutPaymentRepo>(
    () => CheckOutPaymentRepo(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SendCodeOfVerificationRepo>(
    () => SendCodeOfVerificationRepo(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<VerifyCodeOfVerification>(
    () => VerifyCodeOfVerification(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(getIt<ApiService>()),
  );

  // cubit
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<ProfileRepo>()));
  getIt.registerFactory<RegisterUserCubit>(
    () => RegisterUserCubit(getIt<RegisterUser>()),
  );
  getIt.registerFactory<GetAllStationsCubit>(
    () => GetAllStationsCubit(getIt<GetAllStationsRepo>()),
  );
  getIt.registerFactory<GetNearbyStationsCubit>(
    () => GetNearbyStationsCubit(getIt<GetNearbyStationsRepo>()),
  );

  getIt.registerFactory<GetOneStationCubit>(
    () => GetOneStationCubit(getIt<GetOneStationRepo>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit((getIt<LoginRequestRepo>())),
  );

  getIt.registerFactory<GetDetailsOfLineCubit>(
    () => GetDetailsOfLineCubit((getIt<GetLineDetailsRepo>())),
  );

  getIt.registerFactory<GetAllPostsCubit>(
    () => GetAllPostsCubit((getIt<GetAllPostsRepo>())),
  );
  getIt.registerFactory<LikePostCubit>(
    () => LikePostCubit((getIt<LikePostRepo>())),
  );

  getIt.registerFactory<CreatePostCubit>(
    () => CreatePostCubit((getIt<CreatePostRepo>())),
  );
  getIt.registerFactory<PostsCubit>(
    () => PostsCubit((getIt<GetAllPostsOfUserRepo>())),
  );
  getIt.registerFactory<CommentsCubit>(
    () =>
        CommentsCubit(getIt<GetAllCommentsOfPost>(), getIt<PutCommentOnPost>()),
  );

  getIt.registerFactoryParam<ChatCubit, Map<String, dynamic>, void>(
    (params, _) => ChatCubit(
      getIt<SocketService>(),
      getIt<ApiService>(),
      userId: params['userId'],
      chatPartnerId: params['chatPartnerId'],
    ),
  );
  getIt.registerFactory<GetAllChatsCubit>(
    () => GetAllChatsCubit(getIt<GetAllChatsRepo>()),
  );

  getIt.registerFactory<ManageBookSeatCubit>(
    () => ManageBookSeatCubit(
      getIt<BookAndCancelRepo>(),
      getIt<CheckOutPaymentRepo>(),
    ),
  );

  getIt.registerFactory<PathBetweenPointsDartCubit>(
        () => PathBetweenPointsDartCubit(getIt<GetRoute>()),
  );
  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(),
  );

  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(
      getIt<SendCodeOfVerificationRepo>(),
      getIt<VerifyCodeOfVerification>(),
      getIt<ResetPasswordRepo>(),
    ),
  );
}
