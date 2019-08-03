import 'package:surf_util/surf_util.dart';

/// Уведомление
class LocalNotification {
  final String title;
  final String body;
  final NotificationPayload payload;

  LocalNotification({
    this.title,
    this.body,
    this.payload,
  });
}

/// Полезная нагрузка уведомления
class NotificationPayload {
  final NotificationType type;
  final String saleId;

  NotificationPayload({
    this.type,
    this.saleId,
  });
}

/// Тип уведомления
class NotificationType extends Enum<String> {
  const NotificationType(String value) : super(value);

  static const sale = NotificationType('sale');
  static const bonus = NotificationType('bonus');

  static NotificationType byValue(String type) {
    switch (type) {
      case 'sale':
        return sale;
      case 'bonus':
        return bonus;
      default:
        return bonus;
    }
  }
}
