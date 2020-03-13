import 'dart:collection';

import 'package:logger/logger.dart';
import 'package:push_notification/src/base/push_handle_strategy.dart';
import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/init_settings.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_init_settings.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

typedef NotificationCallback = void Function(Map<String, dynamic> payload);

const String pushIdParam = 'localPushId';

/// Wrapper over surf notifications
class NotificationController {
  Notificator _surfNotification;

  Map<int, NotificationCallback> callbackMap =
      HashMap<int, NotificationCallback>();

  NotificationController(
    String androidDefaultIcon,
  ) {
    _surfNotification = Notificator(
        initSettings: InitSettings(
          iosInitSettings: IOSInitSettings(
            requestSoundPermission: false,
            requestAlertPermission: false,
          ),
        ),
        onNotificationTapCallback: _internalOnSelectNotification);
  }

  /// displaying notification from the strategy
  Future<dynamic> show(
    PushHandleStrategy strategy,
    NotificationCallback onSelectNotification,
  ) {
    final androidSpecifics = AndroidNotificationSpecifics(
      channelId: strategy.notificationChannelId,
      channelName: strategy.notificationChannelName,
      autoCancelable: strategy.autoCancelable,
      color: strategy.color,
      icon: strategy.icon,
    );

    final platformSpecifics = NotificationSpecifics(androidSpecifics);

    Logger.d(
        "DEV_INFO receive for show push : ${strategy.payload.title}, ${strategy.payload.body}");

    int pushId = DateTime.now().millisecondsSinceEpoch;
    var tmpPayload = Map.of(strategy.payload.messageData);
    tmpPayload[pushIdParam] = pushId;
    callbackMap[pushId] = onSelectNotification;

    return _surfNotification.show(
      strategy.pushId,
      strategy.payload.title,
      strategy.payload.body,
      data: tmpPayload,
      notificationSpecifics: platformSpecifics,
    );
  }

  Future<dynamic> _internalOnSelectNotification(Map payload) async {
    Logger.d('DEV_INFO onSelectNotification, payload: $payload');

    Map<String, dynamic> tmpPayload = payload;
    int pushId = tmpPayload[pushIdParam];
    var onSelectNotification = callbackMap[pushId];
    callbackMap.remove(pushId);

    return onSelectNotification?.call(tmpPayload);
  }
}
