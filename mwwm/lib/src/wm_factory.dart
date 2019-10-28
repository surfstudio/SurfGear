import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/widget_model.dart';

typedef WidgetModelBuilder = WidgetModel Function(BuildContext);

/// Factory of WidgetModels.
/// WidgetModelBuilder must be registered in this singleton.
class WidgetModelFactory {
  static WidgetModelFactory _instance;

  static WidgetModelFactory instance() {
    _instance ??= WidgetModelFactory._();
    return _instance;
  }

  Map<Type, WidgetModelBuilder> _builders = HashMap();

  WidgetModelFactory._();

  void registerBuilder<W extends WidgetModel>(WidgetModelBuilder builder) {
    _builders[W] = builder;
  }

  WidgetModel by<W>(BuildContext context) => _builders[W](context);
}
