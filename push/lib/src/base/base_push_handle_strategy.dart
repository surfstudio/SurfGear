import 'package:flutter/cupertino.dart';
import 'package:push/push.dart';
import 'package:push/src/base/base_notification_payload.dart';

/// Абстрактная стратегия
abstract class BasePushHandleStrategy<PT extends BaseNotificationPayload> {
  /// Настройки канала
  String notificationChannelId = 'default_push_chanel';
  String notificationChannelName = 'Название канала';
  String notificationDescription = 'Описание канала уведомлений';

  /// ID сообщения
  int pushId = 0;

  /// данные сообщения
  String title;
  String body;
  PT payload;

  /// Исходные данные сообщения
  Map<String, dynamic> messageData;

  /// извлечение данных
  void extractDataFromMap(Map<String, dynamic> map) {
    messageData = Map<String, dynamic>.from(map);
    title = map['title'];
    body = map['body'];
    extractPayloadFromMap(map);
  }

  /// абстрактный метод извлечения данных
  void extractPayloadFromMap(Map<String, dynamic> map);

  /// обработка сообщения
  void onTapNotification(BuildContext context);

  void beforeTapNotificationHandler() {
    var context = PushContextHolder().context;
    onTapNotification(context);
  }
}
