import 'dart:collection';
import 'dart:io';

import 'package:push_notification/src/base/push_handle_strategy.dart';
import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/init_settings.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_init_settings.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

typedef NotificationCallback = void Function(Map<dynamic, dynamic> payload);

const String pushIdParam = 'localPushId';
const String uniqueKey = 'uniqueKey';
const String aps = 'aps';
const String data = 'data';

/// Wrapper over surf notifications
class NotificationController {
  Notificator _surfNotification;

  Map<String, NotificationCallback> callbackMap =
  HashMap<String, NotificationCallback>();

  NotificationController(String androidDefaultIcon,) {
    _surfNotification = Notificator(
        initSettings: InitSettings(
          iosInitSettings: IOSInitSettings(
            requestSoundPermission: true,
            requestAlertPermission: true,
          ),
        ),
        onNotificationTapCallback: _internalOnSelectNotification);
  }

  /// Request notification permissions (iOS only)
  Future<bool> requestPermissions() {
    return _surfNotification.requestPermissions(
      requestSoundPermission: true,
      requestAlertPermission: true,
    );
  }

  /// displaying notification from the strategy
  Future<dynamic> show(PushHandleStrategy strategy,
      NotificationCallback onSelectNotification,) {
    final androidSpecifics = AndroidNotificationSpecifics(
//      channelId: strategy.notificationChannelId,
//      channelName: strategy.notificationChannelName,
      autoCancelable: strategy.autoCancelable,
      color: strategy.color,
      icon: strategy.icon,
    );

    final platformSpecifics = NotificationSpecifics(androidSpecifics);

    print(
        "DEV_INFO receive for show push : ${strategy.payload.title}, ${strategy
            .payload.body}");

    var tmpPayload = Map.of(strategy.payload.messageData);
    String payloadKey;
    if (Platform.isIOS) {
      payloadKey = tmpPayload[aps][uniqueKey];
    } else {
      payloadKey = tmpPayload[data][uniqueKey];
    }
    callbackMap[payloadKey] = onSelectNotification;

    /// На платформе IOS, отображение происходит с помощью системы,
    /// Данный метод используется для регистрации callback метода
    if (Platform.isIOS) {
      return Future.value(true);
    }
    return _surfNotification.show(
      strategy.pushId,
      strategy.payload.title,
      strategy.payload.body,
      data: tmpPayload[Platform.isIOS ? aps : data],
      notificationSpecifics: platformSpecifics,
    );
  }

  Future<dynamic> _internalOnSelectNotification(Map payload) async {
    print('DEV_INFO onSelectNotification, payload: $payload');

    Map<dynamic, dynamic> tmpPayload = payload;
    String pushId;
    if (Platform.isIOS) {
      pushId = tmpPayload[aps][uniqueKey];
    } else {
      pushId = tmpPayload[uniqueKey];
    }
    var onSelectNotification = callbackMap[pushId];
    callbackMap.remove(pushId);

    return onSelectNotification?.call(tmpPayload);
  }
}
