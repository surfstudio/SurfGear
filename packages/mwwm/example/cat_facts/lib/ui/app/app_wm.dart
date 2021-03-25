import 'package:cat_facts/data/app/app_model.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mwwm/mwwm.dart';

class AppWidgetModel extends WidgetModel<AppModel> {
  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
    AppModel model,
  ) : super(baseDependencies, model: model);

  void switchTheme() {
    model.changeTheme();
  }
}

AppWidgetModel createAppWidgetModel(BuildContext context) {
  return AppWidgetModel(
    WidgetModelDependencies(),
    AppModel(),
  );
}
