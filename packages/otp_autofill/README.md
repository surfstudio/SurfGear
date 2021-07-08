# OTP autofill

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/otp_autofill)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/SurfGear?flag=otp_autofill&logo=codecov&logoColor=white)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/otp_autofill?logo=dart&logoColor=white)](https://pub.dev/packages/otp_autofill)
[![Pub Likes](https://badgen.net/pub/likes/otp_autofill)](https://pub.dev/packages/otp_autofill)
[![Pub popularity](https://badgen.net/pub/popularity/otp_autofill)](https://pub.dev/packages/otp_autofill/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/otp_autofill)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

## About

This plugin uses [SMS User Consent API](https://developers.google.com/identity/sms-retriever/user-consent/overview) and [SMS Retriever API](https://developers.google.com/identity/sms-retriever/overview) on Android.

You could use autofill from another input by using OTPStrategy. (e.g. from push-notification).

For testing you could create `TestStrategy`.

## iOS

On iOS OTP autofill is built in `TextField`.
Code from sms stores for 3 minutes.

### Rules for sms

1. Sms must contain the word `code` or it translation to ios supported localizations.
1. Must be only one digit sequence in sms.

### iOS Testing

iOS can receive number from any other number.

## Android

`OTPInteractor.hint` - show system dialog to select saved phone numbers (recommendation from google).
`OTPInteractor.getAppSignature` - create hash-code of your application, that used in [SMS Retriever API](https://developers.google.com/identity/sms-retriever/overview).
`OTPInteractor.startListenUserConsent` - BroadcastReceiver start listen for code from Google Services for 5 minutes. Above 5 minutes raise timeout exception. Using [SMS User Consent API](https://developers.google.com/identity/sms-retriever/user-consent/overview).
`OTPInteractor.startListenRetriever` - BroadcastReceiver start listen for code from Google Services for 5 minutes. Above 5 minutes raise timeout exception. Using [SMS Retriever API](https://developers.google.com/identity/sms-retriever/overview).
`OTPInteractor.stopListenForCode` - use in dispose.

Plugin receive full sms text, need parser for sms.

If you use [SMS User Consent API](https://developers.google.com/identity/sms-retriever/user-consent/overview) then system ask for permission to reed incoming message.

### Rules for sms. SMS User Consent API

1. The message contains a 4-10 character alphanumeric string with at least one number.
2. The message was sent by a phone number that's not in the user's contacts.
3. If you specified the sender's phone number, the message was sent by that number.

### Rules for sms. SMS Retriever API

1. Be no longer than 140 bytes
1. Contain a one-time code that the client sends back to your server to complete the verification flow
1. Include an 11-character hash string that identifies your app ([documentation for server](https://developers.google.com/identity/sms-retriever/verify#computing_your_apps_hash_string), for testing you can get in from `OTPInteractor.getAppSignature`)

### Android Testing

`OTPInteractor.startListenForCode` has `senderPhone` argument. Application start receiving code from this number.

## Usage

You could user `OTPInteractor` to interact with OTP.

For easy implementation you could use `OTPTextEditController` as a controller to your `TextField`.

`OTPTextEditController.startListenUserConsent` - use [SMS User Consent API](user_consent_link), and custom strategies.
`OTPTextEditController.startListenRetriever` - use [SMS Retriever API](retriever_link), and custom strategies.
`OTPTextEditController.startListenOnlyStrategies` - listen only custom strategies.
`OTPTextEditController.stopListen` - use in dispose.

## Installation

Add `otp_autofill` to your `pubspec.yaml` file:

```yaml
dependencies:
  otp_autofill: ^1.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

### Android Installation

Set `minSdkVersion` at least to 19 in `<project root>/project/android/app/build.gradle`.

``` gradle
android {
  ...
  defaultConfig {
    ...
    minSdkVersion 19
    ...
  }
  ...
}
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
