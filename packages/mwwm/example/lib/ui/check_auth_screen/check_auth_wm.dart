import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen_route.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';

/// widget model checks authorization
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

  void _auth() {
    doFuture<bool>(
      _checkAuth(),
      (isUserAuth) async {
        if (isUserAuth) {
          await navigator.push(MainScreenRoute());
        } else {
          await navigator.push(
            LoginScreenRoute(
              argument1: 'hello',
              argument2: 42,
            ),
          );
        }
      },
      onError: handleError,
    );
  }

  Future<bool> _checkAuth() {
    return model.perform(IsUserAuthorize());
  }
}
