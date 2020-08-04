# otp_user_consent_api

#### [SurfGear](https://github.com/surfstudio/SurfGear)

This plugin works only with Android by using [SMS User Consent API](https://developers.google.com/identity/sms-retriever/user-consent/overview).

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
`OTPInteractor.startListenForCode` - BroadcastReceiver start listen for code from Google Services for 5 minutes. Above 5 minutes raise timeout exception.
`OTPInteractor.stopListenForCode` - use in dispose

Plugin receive full sms text, need parser for sms.

System ask the permission to read incoming message.

### Rules for sms

1. The message contains a 4-10 character alphanumeric string with at least one number.
2. The message was sent by a phone number that's not in the user's contacts.
3. If you specified the sender's phone number, the message was sent by that number.

### Testing

`OTPInteractor.startListenForCode` has `senderPhone` argument. Application start receiving code from this number.