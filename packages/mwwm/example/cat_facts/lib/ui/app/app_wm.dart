import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/storage/app/app_storage.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._appStorage,
  ) : super(baseDependencies);

  final AppStorage _appStorage;

  StreamedState<AppTheme> get theme => _appStorage.appTheme;
}

AppWidgetModel createAppWidgetModel(BuildContext context) {
  return AppWidgetModel(
    WidgetModelDependencies(),
    Provider.of<AppStorage>(context, listen: false),
  );
}
