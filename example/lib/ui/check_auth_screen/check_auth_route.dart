import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/performers.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';
import 'package:mwwm_github_client/ui/check_auth_screen/check_auth_screen.dart';
import 'package:mwwm_github_client/ui/check_auth_screen/check_auth_wm.dart';
import 'package:provider/provider.dart';

/// CheckAuthScreen Route
class CheckAuthRoute extends MaterialPageRoute {
  CheckAuthRoute()
      : super(
          builder: (context) => CheckAuthScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => CheckAuthWm(
      context.read<WidgetModelDependencies>(),
      Model([
        IsUserAuthorizePerformer(
          context.read<AuthRepository>(),
        ),
      ]),
      Navigator.of(context),
    );
