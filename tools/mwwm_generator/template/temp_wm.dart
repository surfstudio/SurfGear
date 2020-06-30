import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

import 'di/temp_component.dart';

/// Билдер для [GiftsWidgetModel]
$Temp$WidgetModel create$Temp$WidgetModel(BuildContext context) {
  var component = Injector.of<$Temp$Component>(context).component;
  return $Temp$WidgetModel(
    component.wmDependencies,
    component.navigator
  );
}

/// [WidgetModel] для [$Temp$]
class $Temp$WidgetModel extends WidgetModel {
  final NavigatorState navigator;

  $Temp$WidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
    //todo
  }
}
