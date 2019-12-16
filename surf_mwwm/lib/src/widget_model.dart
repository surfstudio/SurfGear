import 'package:mwwm/mwwm.dart';

/// Surf implementation with optional Model
abstract class SurfWidgetModel extends WidgetModel {
  SurfWidgetModel(
    WidgetModelDependencies baseDependencies, {
    Model model,
  }) : super(
          baseDependencies,
          model ?? Model([]),
        );
}
