[Главная](../main.md)

[Структура UI](structure.md)

# Widget

Для взаимодействия с WidgetModel используется [MwwmWidget](../../packages/mwwm/lib/src/mwwm_widget.dart) — наследник StatefulWidget, умеющий управлять жизненным циклом WidgetModel. Для его инициализации необходимы следующие компоненты:

1. *widgetStateBuilder* — возвращает WidgetState для конструируемого виджета. Аналог createState() в StatefulWidget.

1. *dependenciesBuilder* — возвращает реализацию интерфейса [Component](../../../packages/injector/lib/src/component.dart). Содержит только зависимости для WidgetModel, которые либо получает через конструктор, либо находит с помощью [Injector](../../../packages/injector/lib/src/injector.dart) из контекста.

1. *widgetModelBuilder* — возвращает WidgetModel. Для возможности подмены WidgetModel во время тестирования можно объявить этот билдер необязательным параметром в конструкторе виджета.

Пример:
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