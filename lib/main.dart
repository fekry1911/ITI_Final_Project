import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/di/di.dart';
import 'core/helpers/cach_helper.dart';
import 'core/keys.dart';
import 'core/networking/dio_config.dart';
import 'core/routing/router.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hive initialization
  await Hive.initFlutter();

  // Stripe
  Stripe.publishableKey = publishKey;

  // CacheHelper
  await CacheHelper.init();

  // DioConfig (مهم جداً قبل تسجيل Dio في DI)
  await DioConfig.instance.init();

  // تسجيل dependencies بعد ما Dio جاهز
  configureDependencies();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp(appRouter: AppRouter()));
}
