import 'package:flutter/widgets.dart' show BuildContext;
import 'package:mwwm/mwwm.dart';

AppWidgetModel createAppWidgetModel(BuildContext context) {
  return AppWidgetModel(
    WidgetModelDependencies(),
  );
}

class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);
}
