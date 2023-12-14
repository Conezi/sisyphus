import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../configs/size_config.dart';
import '../res/app_images.dart';
import 'widget/image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() => Timer(const Duration(seconds: 1), handleTimeout);

  void handleTimeout() => changeScreen();

  Future<void> changeScreen() async {
    //Show status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: Center(
          child: ImageView.svg(AppImages.icLogo,
              color: Theme.of(context).iconTheme.color,
              width: SizeConfig.widthOf(50),
              fit: BoxFit.fitWidth)),
    );
  }
}
