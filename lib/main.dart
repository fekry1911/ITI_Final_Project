import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/routing/router.dart';
import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp(appRouter: AppRouter()));
}
