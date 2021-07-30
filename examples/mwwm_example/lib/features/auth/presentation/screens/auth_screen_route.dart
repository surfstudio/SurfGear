import 'package:flutter/material.dart';
import 'package:mwwm_example/features/auth/presentation/screens/auth_screen.dart';

class AuthScreenRoute extends MaterialPageRoute<void> {
  static AuthScreenRoute? _instance;

  static AuthScreenRoute? get instance => _instance;

  AuthScreenRoute()
      : super(
          builder: (context) => const AuthScreen(),
        ) {
    _instance = this;
  }
}
