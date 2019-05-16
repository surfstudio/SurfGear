import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// Шаблон [WidgetModel] для экрана
class TempWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  TempWidgetModel(
      WidgetModelDependencies dependencies,
      this.navigator,
      ) : super(dependencies);

  @override
  void onLoad() {
    //todo
  }
}
