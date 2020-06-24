import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/performers.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen.dart';
import 'package:mwwm_github_client/ui/login_screen/login_wm.dart';
import 'package:provider/provider.dart';

/// login screen route
class LoginScreenRoute extends MaterialPageRoute {
  LoginScreenRoute()
      : super(
          builder: (context) => LoginScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => LoginWm(
      context.read<WidgetModelDependencies>(),
      Model([
        AuthorizeInGithubPerformer(
          context.read<AuthRepository>(),
        ),
      ]),
      Navigator.of(context),
    );
