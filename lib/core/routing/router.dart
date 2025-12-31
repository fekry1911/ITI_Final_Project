import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/di/di.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/featuers/alllChats/logic/get_all_chats_cubit.dart';
import 'package:iti_moqaf/featuers/chat/logic/chat_cubit.dart';
import 'package:iti_moqaf/featuers/chat/screen/chat_screen.dart';
import 'package:iti_moqaf/featuers/community/logic/get_all_posts_cubit.dart';
import 'package:iti_moqaf/featuers/community/logic/like_post_cubit.dart';
import 'package:iti_moqaf/featuers/create_post/logic/create_post_cubit.dart';
import 'package:iti_moqaf/featuers/create_post/screens/add_post.dart';
import 'package:iti_moqaf/featuers/home/logic/home_cubit.dart';
import 'package:iti_moqaf/featuers/home/screens/home_screen.dart';
import 'package:iti_moqaf/featuers/line_details/logic/get_details_of_line_cubit.dart';
import 'package:iti_moqaf/featuers/line_details/screen/line_details.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';
import 'package:iti_moqaf/featuers/login/screen/login_screen.dart';
import 'package:iti_moqaf/featuers/map/map.dart';
import 'package:iti_moqaf/featuers/on_boarding/screen/on_boarding_screen.dart';
import 'package:iti_moqaf/featuers/profile/logic/posts_cubit.dart';
import 'package:iti_moqaf/featuers/profile/logic/profile_cubit.dart';
import 'package:iti_moqaf/featuers/profile/screens/profile_screen.dart';
import 'package:iti_moqaf/featuers/register/logic/register_user_cubit.dart';
import 'package:iti_moqaf/featuers/register/screen/register.dart';
import 'package:iti_moqaf/featuers/register/screen/verify_email_screen.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/code_screen.dart';
import 'package:iti_moqaf/featuers/splash/screen/splash_screen.dart';
import 'package:iti_moqaf/featuers/stations/logic/get_all_stations_cubit.dart';
import 'package:iti_moqaf/featuers/stations/screens/StationsScreen.dart';
import 'package:iti_moqaf/featuers/stations_details/logic/get_one_station_cubit.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/station_details_screen.dart';

import '../../featuers/alllChats/screen/chat_screen.dart';
import '../../featuers/line_details/logic/manage_book_seat_cubit.dart';
import '../../featuers/line_details/screen/widgets/payment_view.dart';
import '../../featuers/reset_password/logic/reset_password_cubit.dart';
import '../../featuers/reset_password/screens/email_screen.dart';
import '../../featuers/reset_password/screens/new_password_creen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return _buildPageRoute(
          settings,
          OnBoardingScreen(),

          transition: TransitionType.slideFromRight,
        );
      case splashScreen:
        return _buildPageRoute(
          settings,
          SplashScreen(),

          transition: TransitionType.fade,
        );
      case loginScreen:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (BuildContext context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),

          transition: TransitionType.fade,
        );
      case registerScreen:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<RegisterUserCubit>(),
            child: RegisterScreen(),
          ),
          transition: TransitionType.scale,
        );
      case homeScreen:
        String id = CacheHelper.getString(key: "userId") ?? '';
        return _buildPageRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => HomeCubit()),

              BlocProvider(create: (context) => getIt<RegisterUserCubit>()),
              if (id.isNotEmpty)
                BlocProvider(
                  create: (_) => getIt<ProfileCubit>()..loadProfile(id),
                ),
              BlocProvider(
                create: (_) => getIt<GetAllStationsCubit>()..getAllStations(),
              ),
              BlocProvider(
                create: (_) => getIt<GetAllPostsCubit>()..getAllPosts(),
              ),
              BlocProvider(create: (_) => getIt<LikePostCubit>()),
              if (id.isNotEmpty)
                BlocProvider(
                  create: (_) => getIt<PostsCubit>()..getAllPostsOfUser(id),
                ),
            ],
            child: HomeScreen(),
          ),
          transition: TransitionType.scale,
        );
      case verifyEmailScreen:
        final email = settings.arguments as String;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<RegisterUserCubit>(),
            child: VerifyEmailScreen(email: email),
          ),
          transition: TransitionType.scale,
        );
      case stationsScreen:
        return _buildPageRoute(
          settings,
          StationsScreen(),
          transition: TransitionType.scale,
        );
      case stationDetailsScreen:
        final stationId = settings.arguments as String;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) =>
                getIt<GetOneStationCubit>()..getOneStationById(stationId),
            child: StationDetailsScreen(),
          ),
          transition: TransitionType.scale,
        );

      case profileScreen:
        final args = settings.arguments as Map<String, dynamic>;

        return _buildPageRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<ProfileCubit>()..loadProfile(args["id"]),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<PostsCubit>()..getAllPostsOfUser(args["id"]),
              ),
              BlocProvider.value(
                value: args["getAllPostsCubit"] as GetAllPostsCubit,
              ),
              BlocProvider.value(value: args["likePost"] as LikePostCubit),
            ],
            child: ProfileScreen(id: args["id"]),
          ),

          transition: TransitionType.slideFromRight,
        );

      case mapScreen:
        return _buildPageRoute(
          settings,
          MapSample(),
          transition: TransitionType.scale,
        );

      case addPost:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildPageRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<CreatePostCubit>()),
              BlocProvider.value(value: args["allPosts"] as GetAllPostsCubit),
              BlocProvider.value(value: args["profilePosts"] as PostsCubit),
            ],
            child: AddPost(),
          ),
          transition: TransitionType.scale,
        );

      case lineScreen:
        final args = settings.arguments as Map<String, String>;
        final lineId = args['lineId']!;
        final stationId = args['stationId']!;
        return _buildPageRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<GetDetailsOfLineCubit>()
                      ..getLineDetails(lineId, stationId),
              ),
              BlocProvider(create: (context) => getIt<ManageBookSeatCubit>()),
            ],
            child: LineDetails(stationId: stationId, lineId: lineId),
          ),
          transition: TransitionType.scale,
        );
      case chatScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<ChatCubit>(param1: args),
            child: ChatScreen(
              name: args["chatPartnerName"],
              avatar: args["chatPartnerAvatar"],
            ),
          ),
        );
      case allChatsScreen:
        String id = settings.arguments as String;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<GetAllChatsCubit>()..getAllChats(id),
            child: AllChatsScreen(),
          ),
          transition: TransitionType.scale,
        );
      case webViewScreen:
        final url = settings.arguments as String;
        return _buildPageRoute(
          settings,
          WebViewScreen(url: url),
          transition: TransitionType.scale,
          // مهم: خلي ال-route ترجع قيمة عند Navigator.pop
        );

      case emailScreen:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: EnterEmail(),
          ),
          transition: TransitionType.scale,
          // مهم: خلي ال-route ترجع قيمة عند Navigator.pop
        );

      case codeScreen:
        final email = settings.arguments as String;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: CodeScreen(email: email,),
          ),
          transition: TransitionType.scale,
          // مهم: خلي ال-route ترجع قيمة عند Navigator.pop
        );

      case newPasswordScreen:
        final token = settings.arguments as String;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: NewPasswordScreen(token: token,),
          ),
          transition: TransitionType.scale,
          // مهم: خلي ال-route ترجع قيمة عند Navigator.pop
        );

      default:
        return null;
    }
  }

  /// Helper function to build custom transitions
  PageRouteBuilder _buildPageRoute(
    RouteSettings settings,
    Widget screen, {
    TransitionType transition = TransitionType.fade,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case TransitionType.slideFromRight:
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.slideFromBottom:
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(
              scale: animation.drive(
                Tween(
                  begin: 0.8,
                  end: 1.0,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.fade:
          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
    );
  }
}

enum TransitionType { slideFromRight, slideFromBottom, fade, scale }
