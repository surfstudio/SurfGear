import 'package:push/src/domain/notification.dart';
import 'package:push/src/res/consts.dart';
import 'package:surf_util/surf_util.dart';

/// Респонс модель пришедшего пуша
class FirebaseNotificationResponse extends Transformable<LocalNotification> {
  final String title;
  final String body;
  final NotificationPayloadResponse payload;

  FirebaseNotificationResponse({
    this.title,
    this.body,
    this.payload,
  });

  static FirebaseNotificationResponse fromJson(Map<String, dynamic> json) {
    final notification = Map<String, dynamic>.from(json['notification'] ?? {});
    final data = Map<String, dynamic>.from(json['data'] ?? {});

    return FirebaseNotificationResponse(
      title: notification['title'] ?? EMPTY_STRING,
      body: notification['body'] ?? EMPTY_STRING,
      payload:
          NotificationPayloadResponse.fromJson(data.isNotEmpty ? data : json),
    );
  }

  @override
  LocalNotification transform() => LocalNotification(
        title: title,
        body: body,
        payload: payload?.transform(),
      );
}

/// Обёртка над json-моделью нагрузки уведомления
class NotificationPayloadResponse
    implements Transformable<NotificationPayload> {
  final String type;
  final String saleId;

  NotificationPayloadResponse({
    this.type,
    this.saleId,
  });

  static NotificationPayloadResponse fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return null;

    return NotificationPayloadResponse(
      type: json['type'],
      saleId: json['saleId'],
    );
  }

  @override
  NotificationPayload transform() {
    return NotificationPayload(
      type: NotificationType.byValue(type),
      saleId: saleId,
    );
  }
}
