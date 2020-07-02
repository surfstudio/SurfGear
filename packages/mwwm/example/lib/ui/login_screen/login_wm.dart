import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';
import 'package:relation/relation.dart';

/// Login screen's widget model
class LoginWm extends WidgetModel<LoginScreen> {
  LoginWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator,
  ) : super(baseDependencies, model: model);

  final loginAction = Action<void>();
  final NavigatorState navigator;

  @override
  void onLoad() {
    super.onLoad();

    print('${widget.argument1} + ${widget.argument2}');
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(
      loginAction.stream,
      (_) {
        doFuture<bool>(
          _login(),
          (isLogin) {
            if (isLogin) {
              navigator.push(MainScreenRoute());
            }
          },
          onError: handleError,
        );
      },
    );
  }

  Future<bool> _login() {
    return model.perform(AuthorizeInGithub());
  }
}
