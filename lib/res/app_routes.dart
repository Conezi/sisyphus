import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/splash_screen.dart';

class AppRoutes {
  ///Route names used through out the app will be specified as static constants here in this format
  static const String splashScreen = 'splashScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    ///Named routes to be added here in this format
    splashScreen: (context) => const SplashScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (routes.keys.contains(settings.name)) {
      return MaterialPageRoute(builder: routes[settings.name]!);
    } else {
      //Default Route is error route
      return CupertinoPageRoute(
          builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
