import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/performers.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen.dart';
import 'package:mwwm_github_client/ui/login_screen/login_wm.dart';
import 'package:provider/provider.dart';

/// login screen route
class LoginScreenRoute extends MaterialPageRoute {
  LoginScreenRoute({String argument1, int argument2})
      : super(
          builder: (context) => LoginScreen(
            widgetModelBuilder: _widgetModelBuilder,
            argument1: argument1,
            argument2: argument2,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => LoginWm(
      WidgetModelDependencies(
        errorHandler: LoginScreenErrorHandler(),
      ),
      Model([
        AuthorizeInGithubPerformer(
          context.read<AuthRepository>(),
        ),
      ]),
      Navigator.of(context),
    );

class LoginScreenErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('LOGIN SCREEN: $e');
  }
}
