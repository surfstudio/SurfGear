import 'package:flutter/widgets.dart';
import 'package:mwwm/src/error_handler.dart';

/// Базовые зависимости для WM
class WidgetModelDependencies {
  final ErrorHandler errorHandler;
  final NavigatorState navigator;

  WidgetModelDependencies({this.errorHandler, this.navigator});
}
