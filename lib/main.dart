
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iti_moqaf/core/networking/path_dio_config.dart';

import 'core/di/di.dart';
import 'core/helpers/cach_helper.dart';
import 'core/keys.dart';
import 'core/networking/dio_config.dart';
import 'core/routing/router.dart';
import 'firebase_options.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase


// ...

  await Firebase.initializeApp(


    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  Stripe.publishableKey = publishKey;

  await CacheHelper.init();

  await DioConfig.instance.init();
  await DioPathConfig.instance.init();

  configureDependencies();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp(appRouter: AppRouter()));
}
