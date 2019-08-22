import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:push/push.dart';
import 'package:rxdart/subjects.dart';

/// Обёртка над локальными уведомлениями
class NotificationController {
  final PushHandleStrategyFactory _strategyFactory;

  final BehaviorSubject<BasePushHandleStrategy> selectNotificationSubject =
      BehaviorSubject();

  FlutterLocalNotificationsPlugin _notificationPlugin;
  SelectNotificationCallback onSelectNotification;

  NotificationController(
    this._strategyFactory,
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
        onSelectNotification: _internalOnSelectNotifacation,
      );
  }

  Future<dynamic> show(BasePushHandleStrategy strategy) {
    final androidSpecific = AndroidNotificationDetails(
      strategy.notificationChannelId,
      strategy.notificationChannelName,
      strategy.notificationDescription,
    );
    final iosSpecific = IOSNotificationDetails();
    final platformSpecifics = NotificationDetails(androidSpecific, iosSpecific);

    debugPrint(
        "DEV_INFO receive for show push : ${strategy.title}, ${strategy.body}");

    return _notificationPlugin.show(
      strategy.pushId,
      strategy.title,
      strategy.body,
      platformSpecifics,
      payload: jsonEncode(strategy.messageData),
    );
  }

  Future<dynamic> _internalOnSelectNotifacation(String payload) {
    print('DEV_INFO onSelectNotification, payload: $payload');

    final payloadJson = jsonDecode(payload);
    var strategy = _strategyFactory.createByData(payloadJson);
    strategy.onTapNotification();

    selectNotificationSubject.add(payloadJson);

    if (onSelectNotification != null) {
      return onSelectNotification(payload);
    }
    return null;
  }
}
