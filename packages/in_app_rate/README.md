# In App Rate

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/in_app_rate)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

## About

Plugin open native dialog for application rate/review.

## Usage

### iOS

iOS part use [SKStoreReviewController](https://developer.apple.com/documentation/storekit/skstorereviewcontroller).
[Best Practices](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews) for a moment to use it.
Note from [documentation](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview).
***
When you call this method while your app is still in development mode, a rating/review request view is always displayed so that you can test the user interface and experience. However, this method has no effect when you call it in an app that you distribute using TestFlight.
***

### Android

Android part use [Google Play In-App Review API](https://developer.android.com/guide/playcore/in-app-review).
[Best Practices](https://developer.android.com/guide/playcore/in-app-review#when-to-request) for a moment to use it.
[Testing](https://developer.android.com/guide/playcore/in-app-review/test), if you set `isTest` to `True` then plugin will use `FakeReviewManager`.

## Installation

Add `in_app_rate` to your `pubspec.yaml` file:

```yaml
dependencies:
  in_app_rate: ^1.0.0
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
