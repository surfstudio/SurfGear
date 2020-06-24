import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';
import 'package:relation/relation.dart';

/// Login screen's widget model
class LoginWm extends WidgetModel {
  LoginWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator,
  ) : super(baseDependencies, model: model);

  final loginAction = Action<void>();
  final NavigatorState navigator;

  @override
  void onBind() {
    super.onBind();
    subscribe(
      loginAction.stream,
      (_) async {
        final bool isLogin = await _login();
        if (isLogin) {
          navigator.push(MainScreenRoute());
        }
      },
    );
  }

  Future<bool> _login() async {
    try {
      final loginRequest = AuthorizeInGithub();
      final isLogin = await model.perform(loginRequest);

      return isLogin;
    } on Exception catch (e) {
      handleError(e);
    }
    return false;
  }
}
