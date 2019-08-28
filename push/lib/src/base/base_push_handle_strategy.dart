import 'package:flutter/cupertino.dart';
import 'package:push/push.dart';

/// Абстрактная стратегия
abstract class BasePushHandleStrategy<PT extends BaseNotificationPayload> {
  /// Настройки канала
  String notificationChannelId = 'default_push_chanel';
  String notificationChannelName = 'Название канала';
  String notificationDescription = 'Описание канала уведомлений';

  /// ID сообщения
  int pushId = 0;

  /// данные сообщения
  PT payload;

  /// абстрактный метод извлечения данных
  void extractPayloadFromMap(Map<String, dynamic> map);

  /// обработка сообщения
  void onTapNotification(NavigatorState navigator);
}
