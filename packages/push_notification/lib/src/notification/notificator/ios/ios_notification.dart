import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_notification_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

/// Notifications for the ios platform
class IOSNotification {
  /// MethodChannel for connecting to ios native platform
  final MethodChannel channel;

  /// Callback notification push
  final OnNotificationTapCallback onNotificationTap;

  /// Callback notification decline
  final OnPemissionDeclineCallback onPermissionDecline;

  IOSNotification({
    this.channel,
    this.onNotificationTap,
    this.onPermissionDecline,
  });

  Future init() async {
    channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          case CALLBACK_OPEN:
            if (onNotificationTap != null) {
              final notificationData = Map.of(call.arguments);
              onNotificationTap(notificationData);
            }
            break;
          case CALLBACK_PERMISSION_DECLINE:
            onPermissionDecline();
            break;
        }
      },
    );
  }

  /// Request permissions
  ///
  /// requestSoundPermission - is play sound
  /// requestSoundPermission - is show alert
  Future<bool> requestPermissions({
    bool requestSoundPermission = false,
    bool requestAlertPermission = false,
  }) async {
    return channel.invokeMethod<bool>(
      CALL_REQUEST,
      <String, dynamic>{
        'requestAlertPermission': requestAlertPermission,
        'requestSoundPermission': requestSoundPermission,
      },
    );
  }

  /// Show notification
  /// id - notification identifier
  /// title - title
  /// body - the main text of the notification
  Future show(
    int id,
    String title,
    String body,
    String imageUrl,
    Map<String, String> data,
    IosNotificationSpecifics notificationSpecifics,
  ) async {
    return channel.invokeMethod(
      CALL_SHOW,
      <String, dynamic>{
        ARG_PUSH_ID: id ?? 0,
        ARG_TITLE: title ?? "",
        ARG_BODY: body ?? "",
        ARG_IMAGE_URL: imageUrl,
        ARG_DATA: data,
      },
    );
  }
}
