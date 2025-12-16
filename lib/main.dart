import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/helpers/cach_helper.dart';
import 'core/routing/router.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp(appRouter: AppRouter()));
}
