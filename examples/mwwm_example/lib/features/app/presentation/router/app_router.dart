import 'package:flutter/material.dart';
import 'package:mwwm_example/features/app/presentation/screens/splash_screen_route.dart';
import 'package:mwwm_example/features/auth/presentation/screens/auth_screen_route.dart';

class AppRouter {
  static const String root = '/';

  static const String splashScreen = '/splashScreen';

  static const String loginScreen = '/loginScreen';

  static final Map<String?, Route Function(Object?)> routes = {
    AppRouter.splashScreen: (data) => SplashScreenRoute(),
    AppRouter.loginScreen: (data) => AuthScreenRoute(),
  };
}
