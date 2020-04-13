import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/widget_model.dart';

typedef WidgetModelBuilder = WidgetModel Function(BuildContext);

/// Factory of WidgetModels.
/// WidgetModelBuilder must be registered in this singleton.
/// 
/// Provide possibility to define all builders at one place.
class WidgetModelFactory {
  static WidgetModelFactory _instance;

  static WidgetModelFactory instance() {
    _instance ??= WidgetModelFactory._();
    return _instance;
  }

  Map<Type, WidgetModelBuilder> _builders = HashMap();

  WidgetModelFactory._();

  /// Register `builder` for specified `WidgetModel` class.
  void registerBuilder<W extends WidgetModel>(WidgetModelBuilder builder) {
    _builders[W] = builder;
  }

  /// Get wm instance by context
  WidgetModel by<W>(BuildContext context) => _builders[W](context);
}
