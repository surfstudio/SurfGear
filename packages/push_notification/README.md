#### [SurfGear](https://github.com/surfstudio/SurfGear)

[Main](../../docs/en/main.md)

[TOC]

# push_notification
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
