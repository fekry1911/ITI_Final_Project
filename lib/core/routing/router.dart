

import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/featuers/on_boarding/screen/on_boarding_screen.dart';

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

      default:
        return null;
    }
  }

  /// Helper function to build custom transitions
  PageRouteBuilder _buildPageRoute(RouteSettings settings, Widget screen,
      {TransitionType transition = TransitionType.fade}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case TransitionType.slideFromRight:
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, 0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.slideFromBottom:
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(0, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(
              scale: animation.drive(
                Tween(begin: 0.8, end: 1.0)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.fade:
          default:
            return FadeTransition(
              opacity: animation,
              child: child,
            );
        }
      },
    );
  }
}

enum TransitionType {
  slideFromRight,
  slideFromBottom,
  fade,
  scale,
}
