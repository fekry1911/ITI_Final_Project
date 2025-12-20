import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/core/di/di.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';
import 'package:iti_moqaf/featuers/map/map.dart';
import 'package:iti_moqaf/featuers/on_boarding/screen/on_boarding_screen.dart';
import 'package:iti_moqaf/featuers/register/screen/register.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/station_details_screen.dart';

import '../../featuers/home/logic/home_cubit.dart';
import '../../featuers/home/screens/home_screen.dart';
import '../../featuers/login/screen/login_screen.dart';
import '../../featuers/register/logic/register_user_cubit.dart';
import '../../featuers/register/screen/verify_email_screen.dart';
import '../../featuers/splash/screen/splash_screen.dart';
import '../../featuers/stations/screens/StationsScreen.dart';
import '../../featuers/stations_details/logic/get_one_station_cubit.dart';
import '../const/const_paths.dart';

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
        return _buildPageRoute(
          settings,
          BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
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
            create: (context) => getIt<GetOneStationCubit>()..getOneStationById(stationId),
            child: StationDetailsScreen(stationId: stationId),
          ),
          transition: TransitionType.scale,
        );

      case mapScreen:
        return _buildPageRoute(
          settings,
          MapSample(),
          transition: TransitionType.scale,
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
