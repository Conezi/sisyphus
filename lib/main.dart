import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'configs/theme_config.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';
import 'res/app_theme.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ListenableBuilder(
      listenable: ThemeConfig.instance,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: AppStrings.appName,
          themeMode: ThemeConfig.instance.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
