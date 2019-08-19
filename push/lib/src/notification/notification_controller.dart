import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:push/src/domain/notification.dart';
import 'package:push/src/notification/request/local_notification_request.dart';
import 'package:push/src/notification/response/local_notification_response.dart';
import 'package:rxdart/subjects.dart';

typedef SelectNotificationCallback = Future<dynamic> Function(
    NotificationPayload payload);

/// Обёртка над локальными уведомлениями
class NotificationController {
  final BehaviorSubject<NotificationPayload> selectNotificationSubject =
      BehaviorSubject();

  final _notificationChannelId;
  final _notificationChannelName;
  final _notificationDescription;

  FlutterLocalNotificationsPlugin _notificationPlugin;
  SelectNotificationCallback onSelectNotification;

  NotificationController(
    String androidDefaultIcon,
    this._notificationChannelId,
    this._notificationChannelName,
    this._notificationDescription,
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
        onSelectNotification: _transformPayload,
      );
  }

  Future<dynamic> show(LocalNotification notification) {
    final androidSpecific = AndroidNotificationDetails(
      _notificationChannelId,
      _notificationChannelName,
      _notificationDescription,
    );
    final iosSpecific = IOSNotificationDetails();
    final platformSpecifics = NotificationDetails(androidSpecific, iosSpecific);

    print("DEV_INFO receive for show push : $notification");
    return _notificationPlugin.show(
      0, //todo добавить поддержку id для удаления уведомления из приложения
      notification.title,
      notification.body,
      platformSpecifics,
      payload: LocalNotificationRequest.from(notification).payload,
    );
  }

  Future<dynamic> _transformPayload(String rawPayload) {
    print('DEV_INFO onSelectNotification, payload: $rawPayload');

    final payloadJson = jsonDecode(rawPayload);
    final payload =
        NotificationPayloadResponse.fromJson(payloadJson).transform();

    selectNotificationSubject.add(payload);

    if (onSelectNotification != null) {
      return onSelectNotification(payload);
    }
    return null;
  }
}
