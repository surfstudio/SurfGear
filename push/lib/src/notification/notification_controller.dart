import 'dart:collection';
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:push/push.dart';

typedef NotificationCallback = void Function(Map<String, dynamic> payload);

const String pushIdParam = 'localPushId';

/// Wrapper over local notifications
class NotificationController {
  FlutterLocalNotificationsPlugin _notificationPlugin;

  Map<int, NotificationCallback> callbackMap =
      HashMap<int, NotificationCallback>();

  NotificationController(
    String androidDefaultIcon,
  ) {
    _notificationPlugin = FlutterLocalNotificationsPlugin()
      ..initialize(
        InitializationSettings(
          AndroidInitializationSettings(androidDefaultIcon),
          IOSInitializationSettings(
              onDidReceiveLocalNotification: (id, title, body, payload) async {
            Logger.d("handle notification% $id , $title, $body, $payload");
          }),
        ),
        onSelectNotification: _internalOnSelectNotification,
      );
  }

  Future<dynamic> show(
    PushHandleStrategy strategy,
    NotificationCallback onSelectNotification,
  ) {
    final androidSpecific = AndroidNotificationDetails(
      strategy.notificationChannelId,
      strategy.notificationChannelName,
      strategy.notificationDescription,
      ongoing: strategy.ongoing,
    );
    final iosSpecific = IOSNotificationDetails();
    final platformSpecifics = NotificationDetails(androidSpecific, iosSpecific);

    Logger.d(
        "DEV_INFO receive for show push : ${strategy.payload.title}, ${strategy.payload.body}");

    int pushId = DateTime.now().millisecondsSinceEpoch;
    var tmpPayload = Map.of(strategy.payload.messageData);
    tmpPayload[pushIdParam] = pushId;
    callbackMap[pushId] = onSelectNotification;

    return _notificationPlugin.show(
      strategy.pushId,
      strategy.payload.title,
      strategy.payload.body,
      platformSpecifics,
      payload: jsonEncode(tmpPayload),
    );
  }

  Future<dynamic> _internalOnSelectNotification(String payload) async {
    Logger.d('DEV_INFO onSelectNotification, payload: $payload');

    Map<String, dynamic> tmpPayload = jsonDecode(payload);
    int pushId = tmpPayload[pushIdParam];
    var onSelectNotification = callbackMap[pushId];
    callbackMap.remove(pushId);

    return onSelectNotification?.call(tmpPayload);
  }
}
