import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';


import 'core/routing/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ITI Moqaf',
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },

          onGenerateRoute: appRouter.generateRoute,
          initialRoute:splashScreen,

          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffoldColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.scaffoldColor
            )
          ),
        );
      },
    );
  }
}
