import 'dart:convert';

import 'package:push/src/domain/notification.dart';

/// Модель отправки данных для показа уведомления
class LocalNotificationRequest {
  final String title;
  final String body;
  final String payload;

  LocalNotificationRequest({
    this.title,
    this.body,
    this.payload,
  });

  static LocalNotificationRequest from(LocalNotification notification) {
    return LocalNotificationRequest(
      title: notification.title,
      body: notification.body,
      payload: notification.payload != null
          ? jsonEncode(<String, dynamic>{
              'type': notification.payload.type.value,
              'saleId': notification.payload.saleId,
            })
          : {},
    );
  }
}
