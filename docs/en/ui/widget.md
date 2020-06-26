
`NOT_ACTUAL`

[Main](../main.md)

[UI Structure](structure.md)

# Widget

To interact with WidgetModel, use [MwwmWidget](../../../packages/mwwm/lib/src/mwwm_widget.dart) — inherited from StatefulWidget, able to manage the life cycle of WidgetModel. To initialize it, the following components are required:

1. *widgetStateBuilder* — returns a WidgetState for the constructed widget. Analog to createState() in StatefulWidget.

1. *dependenciesBuilder* — returns the implementation of the interface [Component](../../../packages/injector/lib/src/component.dart). It contains only dependencies for WidgetModel, which it either gets through the constructor or finds using[Injector](../../../packages/injector/lib/src/injector.dart) from the context.

1. *widgetModelBuilder* — returns WidgetModel. In order to be able to replace WidgetModel during testing, you can declare this builder an optional parameter in the widget constructor.

Example:
```dart
SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  var component = Injector.of<SplashScreenComponent>(context).component;

  return SplashScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
  );
}

class SplashScreen extends MwwmWidget<SplashScreenComponent> {
  SplashScreen([
    WidgetModelBuilder widgetModelBuilder = createSplashScreenWidgetModel,
  ]) : super(
    dependenciesBuilder: (context) => SplashScreenComponent(context),
    widgetStateBuilder: () => _SplashScreenState(),
    widgetModelBuilder: widgetModelBuilder,
  );
}

class _SplashScreenState extends WidgetState<SplashScreenWidgetModel> {…}
```