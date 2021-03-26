import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/storage/app/app_storage.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.appStorage,
  ) : super(baseDependencies);

  final AppStorage appStorage;

  StreamedState<AppTheme> get theme => appStorage.appTheme;
}

AppWidgetModel createAppWidgetModel(BuildContext context) {
  return AppWidgetModel(
    WidgetModelDependencies(),
    AppStorage(),
  );
}
