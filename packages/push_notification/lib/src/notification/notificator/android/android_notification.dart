import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

/// Notifications for the android platform
class AndroidNotification {
  /// MethodChannel for connecting to android native code
  final MethodChannel channel;

  /// Callback notification push
  final OnNotificationTapCallback onNotificationTap;

  AndroidNotification({
    this.channel,
    this.onNotificationTap,
  });

  /// Initialize notification
  ///
  /// Initializes notification parameters and click listener
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
        }
      },
    );
    return channel.invokeMethod(CALL_INIT);
  }

  /// Show notification
  ///
  /// id - notification identifier
  /// title - title
  /// body - the main text of the notification
  /// notificationDetails - notification details
  Future show(
    int id,
    String title,
    String body,
    Map<String, String> data,
    AndroidNotificationSpecifics notificationSpecifics,
  ) async {
    return channel.invokeMethod(
      CALL_SHOW,
      <String, dynamic>{
        ARG_PUSH_ID: id ?? 0,
        ARG_TITLE: title ?? "",
        ARG_BODY: body ?? "",
        ARG_DATA: data,
        ARG_NOTIFICATION_SPECIFICS: notificationSpecifics != null
            ? notificationSpecifics.toMap()
            : Map(),
      },
    );
  }
}
