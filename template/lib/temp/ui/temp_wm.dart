import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// [WidgetModel] для экрана <todo>
class TempWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  TempWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
    //todo
  }
}
