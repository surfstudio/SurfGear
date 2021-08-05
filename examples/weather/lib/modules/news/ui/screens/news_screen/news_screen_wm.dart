import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:weather/error_handlers/app_error_handler.dart';

class NewsScreenWidgetModel extends WidgetModel {
  NewsScreenWidgetModel(WidgetModelDependencies baseDependencies)
      : super(baseDependencies);
}

NewsScreenWidgetModel createNewsScreenWidgetModel(BuildContext context) {
  return NewsScreenWidgetModel(
    WidgetModelDependencies(errorHandler: AppErrorHandler(context: context)),
  );
}
