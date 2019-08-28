import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:push/push.dart';
import 'package:rxdart/subjects.dart';

typedef NotificationCallback = void Function(String payload);

/// Обёртка над локальными уведомлениями
class NotificationController {
  final BehaviorSubject<BasePushHandleStrategy> selectNotificationSubject =
      BehaviorSubject();

  FlutterLocalNotificationsPlugin _notificationPlugin;
  SelectNotificationCallback onSelectNotification;

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

  Future<dynamic> show(BasePushHandleStrategy strategy,
      NotificationCallback onSelectNotification) {
    final androidSpecific = AndroidNotificationDetails(
      strategy.notificationChannelId,
      strategy.notificationChannelName,
      strategy.notificationDescription,
    );
    final iosSpecific = IOSNotificationDetails();
    final platformSpecifics = NotificationDetails(androidSpecific, iosSpecific);

    Logger.d(
        "DEV_INFO receive for show push : ${strategy.payload.title}, ${strategy.payload.body}");

    this.onSelectNotification = onSelectNotification;
    return _notificationPlugin.show(
      strategy.pushId,
      strategy.payload.title,
      strategy.payload.body,
      platformSpecifics,
      payload: jsonEncode(strategy.payload.messageData),
    );
  }

  Future<dynamic> _internalOnSelectNotification(String payload) async {
    Logger.d('DEV_INFO onSelectNotification, payload: $payload');
    if (onSelectNotification != null) {
      return onSelectNotification(payload);
    }
  }
}
