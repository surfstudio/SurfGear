# Tab Navigator

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/tabnavigator)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/SurfGear?flag=tabnavigator&logo=codecov&logoColor=white)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/tabnavigator?logo=dart&logoColor=white)](https://pub.dev/packages/tabnavigator)
[![Pub Likes](https://badgen.net/pub/likes/tabnavigator)](https://pub.dev/packages/tabnavigator)
[![Pub popularity](https://badgen.net/pub/popularity/tabnavigator)](https://pub.dev/packages/tabnavigator/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/tabnavigator)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

## About

Possibly the most common style of navigation in mobile apps is tab-based navigation.
This module can manage the tabs on the screen.

## Usage

* Add [TabNavigator](lib/src/tab_navigator.dart) to your widget.
* Add mapping of tabs to widgets inside the tab via [mappedTabs](lib/src/tab_navigator.dart#L22).
* Add a subscription to the stream of selected tabs through [selectedTabStream](lib/src/tab_navigator.dart#L23).
* Define a tab to be opened by default through [initialTab](lib/src/tab_navigator.dart#L24).
* Using [transitionsBuilder](lib/src/tab_navigator.dart#L27) and [transitionDuration](lib/src/tab_navigator.dart#L28), you can define a custom transformation to display the contents of the tab.

## Installation

Add `tabnavigator` to your `pubspec.yaml` file:

```yaml
dependencies:
  tabnavigator: ^1.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

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
