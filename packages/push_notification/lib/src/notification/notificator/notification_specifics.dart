import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_notification_specifics.dart';

/// Specific notification settings for platforms
class NotificationSpecifics {
  /// Settings for anroid
  AndroidNotificationSpecifics androidNotificationSpecifics;

  IosNotificationSpecifics iosNotificationSpecifics;

  NotificationSpecifics(this.androidNotificationSpecifics);
}
