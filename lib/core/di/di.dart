import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:iti_moqaf/core/logic/comment_cubit/comments_cubit.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';
import 'package:iti_moqaf/core/networking/dio_config.dart';
import 'package:iti_moqaf/core/repo/get_all_comments_post.dart';
import 'package:iti_moqaf/core/repo/put_comment_on_post.dart';
import 'package:iti_moqaf/featuers/alllChats/data/repo/get_all_chats_repo.dart';
import 'package:iti_moqaf/featuers/alllChats/logic/get_all_chats_cubit.dart';
import 'package:iti_moqaf/featuers/community/data/repo/get_all_posts_repo.dart';
import 'package:iti_moqaf/featuers/community/data/repo/like_post_repo.dart';
import 'package:iti_moqaf/featuers/community/logic/get_all_posts_cubit.dart';
import 'package:iti_moqaf/featuers/community/logic/like_post_cubit.dart';
import 'package:iti_moqaf/featuers/create_post/data/create_post_repo.dart';
import 'package:iti_moqaf/featuers/create_post/logic/create_post_cubit.dart';
import 'package:iti_moqaf/featuers/line_details/data/repo/get_line_details_repo.dart';
import 'package:iti_moqaf/featuers/line_details/logic/get_details_of_line_cubit.dart';
import 'package:iti_moqaf/featuers/login/data/repo/login_request_repo.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';
import 'package:iti_moqaf/featuers/near_stations/data/repo/get_nearby_stations.dart';
import 'package:iti_moqaf/featuers/near_stations/logic/get_nearby_stations_cubit.dart';
import 'package:iti_moqaf/featuers/profile/data/repo/get_all_posts_repo.dart';
import 'package:iti_moqaf/featuers/profile/data/repo/profile_repo.dart';
import 'package:iti_moqaf/featuers/profile/logic/posts_cubit.dart';
import 'package:iti_moqaf/featuers/profile/logic/profile_cubit.dart';
import 'package:iti_moqaf/featuers/register/data/repo/register_user.dart';
import 'package:iti_moqaf/featuers/register/logic/register_user_cubit.dart';
import 'package:iti_moqaf/featuers/stations/data/model/repo/get_all_stations-repo.dart';
import 'package:iti_moqaf/featuers/stations/logic/get_all_stations_cubit.dart';
import 'package:iti_moqaf/featuers/stations_details/data/repo/get_one_station_repo.dart';
import 'package:iti_moqaf/featuers/stations_details/logic/get_one_station_cubit.dart';

import '../../featuers/chat/logic/chat_cubit.dart';
import '../../featuers/line_details/data/repo/book_cancel_repo.dart';
import '../../featuers/line_details/logic/manage_book_seat_cubit.dart';
import '../networking/socket_service.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  Dio dio = DioConfig.instance.dio;

  getIt.registerLazySingleton<Dio>(() => dio);
  // api service
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<SocketService>(() => SocketService());



  //repos
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<ApiService>()),
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
    () => ManageBookSeatCubit(getIt<BookAndCancelRepo>()),
  );
}
