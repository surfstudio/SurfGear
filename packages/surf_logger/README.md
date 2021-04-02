# Surf Logger

[![Build Status](https://github.com/surfstudio/SurfGear/workflows/build/badge.svg)](https://github.com/surfstudio/SurfGear)
[![Coverage Status](https://codecov.io/gh/surfstudio/SurfGear/branch/dev/graph/badge.svg?flag=surf_logger)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/surf_logger)](https://pub.dev/packages/surf_logger)
[![Pub Likes](https://badgen.net/pub/likes/surf_logger)](https://pub.dev/packages/surf_logger)
![Flutter Platform](https://badgen.net/pub/flutter-platform/surf_logger)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolset made by [Surf](https://surf.ru).

## About

Logger for Dart & Flutter

## Usage

Main classes:

* [Logger](./lib/src/logger.dart)
* [RemoteLogger](./lib/src/remote_logger.dart)

## Logger

[Logger](./lib/src/logger.dart) is used as a singleton. The main methods:

* .`d` - debug
* .`w` - warn, for expected error
* .`e` - error

You can use either [DebugLogStrategy](./lib/src/strategies/impl/debug_strategy.dart) as strategy for [Logger](./lib/src/logger.dart) or [RemoteLogStrategy](./lib/src/strategies/impl/remote_strategy.dart) for [RemoteLogger](./lib/src/remote_logger.dart). Or create your own strategy by implementing [LogStrategy](./lib/src/strategies/log_strategy.dart).

When adding [RemoteLogStrategy](lib/src/strategies/impl/remote_strategy.dart) to the remote server, all logs are sent above the WARN level.

In order not to pollute Crashlytics we use `Logger # w ()` for the expected errors.

## Installation

Add `surf_logger` to your `pubspec.yaml` file:

```yaml
dependencies:
  surf_logger: ^1.0.0
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
