import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen_route.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';

/// check auth wm
class CheckAuthWm extends WidgetModel {
  CheckAuthWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator,
  ) : super(
          baseDependencies,
          model: model,
        );

  final NavigatorState navigator;

  @override
  void onLoad() {
    super.onLoad();
    _auth();
  }

  Future<void> _auth() async {
    final isUserAuth = await _checkAuth();
    if (isUserAuth) {
      await navigator.push(MainScreenRoute());
    } else {
      await navigator.push(LoginScreenRoute());
    }
  }

  Future<bool> _checkAuth() async {
    try {
      final userAuthRequest = IsUserAuthorize();
      final isUserAuthorized = await model.perform(userAuthRequest);

      return isUserAuthorized;
    } on Exception catch (e) {
      handleError(e);
    }

    return false;
  }
}
