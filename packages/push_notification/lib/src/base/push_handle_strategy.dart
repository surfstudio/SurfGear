import 'package:flutter/cupertino.dart';
import 'package:push_notification/src/base/notification_payload.dart';

/// abstract notification processing strategy
abstract class PushHandleStrategy<PT extends NotificationPayload> {
  PushHandleStrategy(this.payload);

  /// Android notification channel id
  ///
  /// "@string/notification_channel_id""
  String notificationChannelId;

  /// Android notification channel name
  ///
  /// "@string/notification_channel_name"
  String notificationChannelName;

  /// push id
  int pushId = 0;

  /// Auto close notification
  bool autoCancelable = false;

  /// Path to string resource color notification icons
  /// "@color/notificaion_icon_color_name"
  String color;

  /// Path to string resource notification icons
  /// "@mipmap/notificaion_icon_name"
  String icon;

  /// non-removable notification
  /// Android only
  bool ongoing = false;

  /// Indicates if a sound should be played when the notification is displayed.
  bool playSound = true;

  /// Display an alert when the notification is triggered while app is in the foreground.
  /// iOS 10+ only
  bool presentAlert = true;

  /// notification payload
  final PT payload;

  /// function that is called to process notification clicks
  void onTapNotification(NavigatorState navigator);

  /// function that is called to process notification background
  void onBackgroundProcess(Map<String, dynamic>message);
}
