import 'package:flutter/material.dart';
import 'package:mwwm_example/features/app/presentation/screens/splash_screen.dart';

class SplashScreenRoute extends MaterialPageRoute<void> {
  static SplashScreenRoute? _instance;

  static SplashScreenRoute? get instance => _instance;

  SplashScreenRoute()
      : super(
          builder: (context) => const SplashScreen(),
        ) {
    _instance = this;
  }
}
