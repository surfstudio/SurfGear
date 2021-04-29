# Push Notification

[![Build Status](https://github.com/surfstudio/SurfGear/workflows/build/badge.svg)](https://github.com/surfstudio/SurfGear)
[![Coverage Status](https://codecov.io/gh/surfstudio/SurfGear/branch/dev/graph/badge.svg?flag=push_notification)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/push_notification)](https://pub.dev/packages/push_notification)
[![Pub Likes](https://badgen.net/pub/likes/push_notification)](https://pub.dev/packages/push_notification)
![Flutter Platform](https://badgen.net/pub/flutter-platform/push_notification)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

## About

Library for implementing push notifications.
The module contains the main work with push notifications.

## Usage

An example of using the library can be found in [example](example).

* Create a notification data type through inheritance `NotificationPayload`
* Create a strategy for handling notifications through inheritance `PushHandleStrategy`
* Create a factory of strategies through inheritance `PushHandleStrategyFactory`

* To receive notifications, you need to create an instance. `MessagingService`
* To display notifications, you need to create an instance `NotificationController`.
* And pass created instances when creating `PushHandler` that will create the strategy using the factory.

* In the notification there should be a field: `click_action: FLUTTER_NOTIFICATION_CLICK`
* in manifest in \<activity\> you need to add intent filter:
```xml
<intent-filter>
      <action android:name="FLUTTER_NOTIFICATION_CLICK" />
      <category android:name="android.intent.category.DEFAULT" />
</intent-filter>
```

## Installation

Add `push_notification` to your `pubspec.yaml` file:

```yaml
dependencies:
  push_notification: ^1.0.0
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
