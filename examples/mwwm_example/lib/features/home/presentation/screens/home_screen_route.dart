import 'package:flutter/material.dart';
import 'package:mwwm_example/features/home/presentation/screens/home_screen.dart';

class HomeScreenRoute extends MaterialPageRoute<void> {
  static HomeScreenRoute? _instance;

  static HomeScreenRoute? get instance => _instance;

  HomeScreenRoute()
      : super(
          builder: (context) => const HomeScreen(),
        ) {
    _instance = this;
  }
}
