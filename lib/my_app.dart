import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/const/const_paths.dart';
import 'core/routing/router.dart';
import 'core/theme/color/colors.dart';
import 'core/theme/text_theme/text_theme.dart';

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
            useMaterial3: true,
            fontFamily: 'Cairo', // Assuming Cairo or similar from GoogleFonts is used/desired, otherwise default
            scaffoldBackgroundColor: AppColors.background,
            primaryColor: AppColors.primary,
            
            // Color Scheme
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              secondary: AppColors.secondary,
              surface: AppColors.surface,
              surfaceContainerHighest: AppColors.surfaceVariant,
              error: AppColors.error,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
              outline: AppColors.border,
            ),

            // AppBar Theme
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.background,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: AppTextStyle.font18BlackBold.copyWith(
                color: AppColors.textPrimary,
                fontSize: 20.sp,
              ),
              iconTheme: IconThemeData(color: AppColors.textPrimary),
              surfaceTintColor: Colors.transparent, 
            ),

            // Card Theme
            cardTheme: CardThemeData(
              color: AppColors.surface,
              elevation: 0, // We will use shadow for "ModernCard" feel manually mostly, but default is 0 for flat look with border or shadow
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
                side: const BorderSide(color: AppColors.border, width: 1),
              ),
            ),

            // Button Theme
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                textStyle: AppTextStyle.font16WhiteSemiBold.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
              ),
            ),

            // Input Decoration Theme
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              prefixIconColor: AppColors.textSecondary,
              hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14.sp),
            ),
            
            // Text Theme (Global)
            textTheme: TextTheme(
              bodyMedium: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              titleMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),

            // Transition
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),

        );
      },
    );
  }
}