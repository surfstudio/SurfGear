import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_template/domain/notification.dart';
import 'package:flutter_template/interactor/common/push/notification/response/local_notification_response.dart';
import 'package:flutter_template/ui/res/assets.dart';
import 'package:flutter_template/ui/res/strings/strings.dart';

/// Обёртка над локальными уведомлениями
class NotificationController {
  FlutterLocalNotificationsPlugin _notificationPlugin;

  NotificationController() {
    _notificationPlugin = FlutterLocalNotificationsPlugin()
      ..initialize(
        InitializationSettings(
          AndroidInitializationSettings(androidMipMapIcon),
          IOSInitializationSettings(),
        ),
        onSelectNotification: _onSelectNotification,
      );
  }

  /// показать уведомление
  show(Map<String, dynamic> message) {
    final notification =
        FirebaseNotificationResponse.fromMessage(message).transform();
    _show(notification);
  }

  Future _show(Notification notification) async {
    final androidSpecific = AndroidNotificationDetails(
      notificationChannelId,
      notificationChannelName,
      notificationDescription,
    );
    final iosSpecific = IOSNotificationDetails();
    final platformSpecifics = NotificationDetails(androidSpecific, iosSpecific);

    print("DEV_INFO receive for show push : $notification");
    await _notificationPlugin.show(
      0, //todo добавить поддержку id для удаления уведомления из приложения
      notification.title,
      notification.text,
      platformSpecifics,
    );
  }

  Future _onSelectNotification(String payload) {
    //todo нажато на уведомление
  }
}
