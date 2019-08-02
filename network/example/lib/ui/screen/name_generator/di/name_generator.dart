import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:name_generator/ui/app/di/app.dart';
import 'package:name_generator/ui/screen/name_generator/name_generator_wm.dart';

/// Component для экрана счетчика
class NameGeneratorComponent
    implements BaseWidgetModelComponent<NameGeneratorWidgetModel> {
  @override
  NameGeneratorWidgetModel wm;

  NameGeneratorComponent(
    AppComponent parentComponent,
    NavigatorState navigator,
  ) {
    wm = NameGeneratorWidgetModel(
      WidgetModelDependencies(),
      navigator,
      parentComponent.nameGeneratorInteractor,
    );
  }
}
