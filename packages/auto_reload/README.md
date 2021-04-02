# Auto Reload

[![Build Status](https://github.com/surfstudio/SurfGear/workflows/build/badge.svg)](https://github.com/surfstudio/SurfGear)
[![Coverage Status](https://codecov.io/gh/surfstudio/SurfGear/branch/dev/graph/badge.svg?flag=auto_reload)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/auto_reload)](https://pub.dev/packages/auto_reload)
[![Pub Version (including pre-releases)](https://img.shields.io/pub/v/auto_reload?include_prereleases)](https://pub.dev/packages/auto_reload)
[![Pub Likes](https://badgen.net/pub/likes/auto_reload)](https://pub.dev/packages/auto_reload)
![Flutter Platform](https://badgen.net/pub/flutter-platform/auto_reload)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolset made by [Surf](https://surf.ru).

## About

A library that helps to perform actions with some periodicity

## Usage

### AutoReload

main classes:

* [AutoReloader](/lib/src/mixin/auto_reloader.dart)
* [AutoReloadMixin](/lib/src/mixin/auto_reload_mixin.dart)

usage:

1. Create abstract class that should be able to reload data should implements [AutoReloader]
2. Apply mixin on a child (that implements [AutoReloader])
3. override [autoReload]
4. call [startAutoReload] for start and [cancelAutoReload] for dispose

### AutoRequestManager

main classes:

* [AutoFutureManager](/lib/src/manager/base/auto_future_manager.dart)
* [AutoRequestManager](/lib/src/manager/impl/auto_request_manager.dart)

Main feature of [AutoRequestManager] that requests will only start restarting when a connection is made.
It implemented by a third-party library names [connectivity](https://pub.dev/packages/connectivity).

usage:

1. Add your request in [autoReload]
2. Wait callback about successful completion

## Installation

Add `auto_reload` to your `pubspec.yaml` file:

```yaml
dependencies:
  auto_reload: ^1.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

For issues, file directly in the [main SurfGear repo](https://github.com/surfstudio/SurfGear).

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

You PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
