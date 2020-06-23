import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/android/android_notification.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_notification.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';

/// Callback notification clicks
///
/// notificationData - notification data
typedef void OnNotificationTapCallback(Map notificationData);

/// Callback permission decline
typedef void OnPemissionDeclineCallback();

/// Channels and methods names
const String CHANNEL_NAME = "surf_notification";
const String CALL_INIT = "initialize";
const String CALL_SHOW = "show";
const String CALL_REQUEST = "request";
const String CALLBACK_OPEN = "notificationOpen";
const String CALLBACK_PERMISSION_DECLINE = "permissionDecline";

/// Arguments names
const String ARG_PUSH_ID = "pushId";
const String ARG_TITLE = "title";
const String ARG_BODY = "body";
const String ARG_IMAGE_URL = "imageUrl";
const String ARG_DATA = "data";
const String ARG_NOTIFICATION_SPECIFICS = "notificationSpecifics";

/// Util for displaying notifications for android and ios
class Notificator {
  MethodChannel _channel = const MethodChannel(CHANNEL_NAME);
  IOSNotification _iosNotification;
  AndroidNotification _androidNotification;

  /// Callback notification clicks
  OnNotificationTapCallback onNotificationTapCallback;

  /// Callback notification decline(ios only)
  final OnPemissionDeclineCallback onPermissionDecline;

  Notificator({
    this.onNotificationTapCallback,
    this.onPermissionDecline,
  }) {
    _init();
  }

  Future _init() async {
    if (Platform.isAndroid) {
      _androidNotification = AndroidNotification(
        channel: _channel,
        onNotificationTap: (notificationData) =>
            onNotificationTapCallback(notificationData),
      );
      return _androidNotification.init();
    } else if (Platform.isIOS) {
      _iosNotification = IOSNotification(
        channel: _channel,
        onNotificationTap: (notificationData) {
          return onNotificationTapCallback(notificationData);
        },
        onPermissionDecline: () {
          return onPermissionDecline();
        },
      );
      return _iosNotification.init();
    }
  }

  /// Request notification permissions (iOS only)
  Future<bool> requestPermissions({
    bool requestSoundPermission = false,
    bool requestAlertPermission = false,
  }) async {
    if (Platform.isAndroid) return true;
    return _iosNotification.requestPermissions(
      requestSoundPermission: requestSoundPermission,
      requestAlertPermission: requestAlertPermission,
    );
  }

  /// Request to display notifications
  ///
  /// id - notification identifier
  /// title - title
  /// body - the main text of the notification
  /// data - data for notification
  Future show(
    int id,
    String title,
    String body, {
    String imageUrl,
    Map<String, String> data,
    NotificationSpecifics notificationSpecifics,
  }) async {
    if (Platform.isAndroid) {
      return _androidNotification.show(
        id,
        title,
        body,
        imageUrl,
        data,
        notificationSpecifics.androidNotificationSpecifics,
      );
    } else if (Platform.isIOS) {
      return _iosNotification.show(
        id,
        title,
        body,
        imageUrl,
        data,
        notificationSpecifics.iosNotificationSpecifics,
      );
    }
  }
}
