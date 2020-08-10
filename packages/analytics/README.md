#### [SurfGear](https://github.com/surfstudio/SurfGear)

# analytics

Interface for working with analytic services.

## Description

The library is supposed to unify work with various analytic services. The main actors are:

* **AnalyticAction** — any action that is valuable for analytics. Usually it is a "button pressed" or "screen opened" type of event but the main criterion is a possibility to be handled by `AnalyticActionPerformer`.
* **AnalyticActionPerformer** — a performer of specific actions used to incapsulate work with a certain analytics service. Typically implemented by transforming `AnalyticAction` into a required format as well as calling *send()* of a third-party library.
* **AnalyticService** — a unified entry point for several `AnalyticActionPerformer`s.

## Example

The easiest interaction with the library is as follows:

1. Determine the actions that ought to be recorded in the analytics service:
```dart
class MyAnalyticAction implements AnalyticAction {
    final String key;
    final String value;

    MyAnalyticAction(this.key, this.value);
}

class ButtonPressedAction extends MyAnalyticAction {
    ButtonPressedAction() : super("button_pressed", null);
}

class ScreenOpenedAction extends MyAnalyticAction {
    ScreenOpenedAction({String param}) : super("screen_opened", param);
}
```

2. Implement action performer:
```dart
class MyAnalyticActionPerformer
    implements AnalyticActionPerformer<MyAnalyticAction> {
  final SomeAnalyticService _service;

  MyAnalyticActionPerformer(this._service);

  @override
  bool canHandle(AnalyticAction action) => action is MyAnalyticAction;

  @override
  void perform(MyAnalyticAction action) {
    _service.send(action.key, action.value);
  }
}
```

3. Add performer to the service:
```dart
    final analyticService = DefaultAnalyticService();
    analyticService.addActionPerformer(
        MyAnalyticActionPerformer(SomeAnalyticService()),
    );
```

Use:
```dart
    analyticService.performAction(ButtonPressedAction());
```