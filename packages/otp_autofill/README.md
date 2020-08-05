# otp_autofill

#### [SurfGear](https://github.com/surfstudio/SurfGear)

For sms autofill plugin use [SMS User Consent API](user_consent_link) and [SMS Retriever API](retriever_link) on Android. IOS sms autofill built in `TextField` widget.

You could use autofill from another input by using OTPStrategy. (e.g. from push-notification)

For testing you could create TestStrategy.

## iOS

in iOS OTP autofill is built in `TextField`.
Code from sms store for 3 minutes.

### Rules for sms

1. Sms must contain the word `code` or it translation to ios supported localizations.
1. Must be only one digit sequence in sms.

### Testing

iOS can receive number from any other number.

## Android

`OTPInteractor.hint` - show system dilog to select saved phone numbers (recommendation from google)
`OTPInteractor.getAppSignature` - create hash-code of your application, that used in [SMS Retriever API](retriever_link)
`OTPInteractor.startListenUserConsent` - BroadcastReceiver start listen for code from Google Services for 5 minutes. Above 5 minutes raise timeout exception. Using [SMS User Consent API](user_consent_link)
`OTPInteractor.startListenRetriever` - BroadcastReceiver start listen for code from Google Services for 5 minutes. Above 5 minutes raise timeout exception. Using [SMS Retriever API](retriever_link)
`OTPInteractor.stopListenForCode` - use in dispose

Plugin receive full sms text, need parser for sms.

If you use [SMS User Consent API](user_consent_link) then system ask for permission to reed incomming message.

### Rules for sms. SMS User Consent API

1. The message contains a 4-10 character alphanumeric string with at least one number.
2. The message was sent by a phone number that's not in the user's contacts.
3. If you specified the sender's phone number, the message was sent by that number.

### Rules for sms. SMS Retriever API

1. Be no longer than 140 bytes
1. Contain a one-time code that the client sends back to your server to complete the verification flow
1. Include an 11-character hash string that identifies your app ([documentation for server](https://developers.google.com/identity/sms-retriever/verify#computing_your_apps_hash_string), for testing you can get in from `OTPInteractor.getAppSignature`)

### Testing

`OTPInteractor.startListenForCode` has `senderPhone` argument. Application start receiving code from this number.

[user_consent_link]:https://developers.google.com/identity/sms-retriever/user-consent/overview
[retriever_link]:https://developers.google.com/identity/sms-retriever/overview

## Usage

You could user `OTPInteractor` to interact with OTP.

For easy implementation you could use `OTPTextEditController` as a controller to your `TextField`.

`OTPTextEditController.startListenUserConsent` - use [SMS User Consent API](user_consent_link), and custom strategies.
`OTPTextEditController.startListenRetriever` - use [SMS Retriever API](retriever_link), and custom strategies.
`OTPTextEditController.startListenOnlyStrategies` - listen only custom strategies.
`OTPTextEditController.stopListen` - use in dispose.
