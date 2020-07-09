import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen.dart';
import 'package:mwwm_github_client/ui/main_screen/main_wm.dart';
import 'package:provider/provider.dart';

/// Main screen route
class MainScreenRoute extends MaterialPageRoute {
  MainScreenRoute()
      : super(
          builder: (context) => MainScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => MainWm(
      context.read<WidgetModelDependencies>(),
      Model([]),
    );
