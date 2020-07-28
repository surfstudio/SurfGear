import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

/// Notifications for the android platform
class AndroidNotification {
  AndroidNotification({
    this.channel,
    this.onNotificationTap,
  });

  /// MethodChannel for connecting to android native code
  final MethodChannel channel;

  /// Callback notification push
  final OnNotificationTapCallback onNotificationTap;

  /// Initialize notification
  ///
  /// Initializes notification parameters and click listener
  Future init() async {
    channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          case openCallback:
            if (onNotificationTap != null) {
              final Map<String, String> notificationData = Map.of(
                call.arguments as Map<Object, Object>,
              ).map(
                (key, value) => MapEntry(
                  key.toString(),
                  value.toString(),
                ),
              );
              onNotificationTap(notificationData);
            }
            break;
        }
      },
    );
    return channel.invokeMethod<dynamic>(callInit);
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
    String imageUrl,
    Map<String, String> data,
    AndroidNotificationSpecifics notificationSpecifics,
  ) async {
    return channel.invokeMethod<dynamic>(
      callShow,
      <String, dynamic>{
        pushIdArg: id ?? 0,
        titleArg: title ?? '',
        bodyArg: body ?? '',
        imageUrlArg: imageUrl,
        dataArg: data,
        notificationSpecificsArg: notificationSpecifics != null
            ? notificationSpecifics.toMap()
            : <String, Object>{},
      },
    );
  }
}
