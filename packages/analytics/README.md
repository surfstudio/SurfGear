# Analytics

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/analytics)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/SurfGear?flag=analytics&logo=codecov&logoColor=white)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/analytics?logo=dart&logoColor=white)](https://pub.dev/packages/analytics)
[![Pub Likes](https://badgen.net/pub/likes/analytics)](https://pub.dev/packages/analytics)
[![Pub popularity](https://badgen.net/pub/popularity/analytics)](https://pub.dev/packages/analytics/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/analytics)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

## Description

Interface for working with analytic services.  
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

Usage:

```dart
    analyticService.performAction(ButtonPressedAction());
```

## Installation

Add `analytics` to your `pubspec.yaml` file:

```yaml
dependencies:
  analytics: ^1.0.0
```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

For issues, file directly in the [main SurfGear repo](https://github.com/surfstudio/SurfGear).

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
