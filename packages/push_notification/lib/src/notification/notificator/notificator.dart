import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/android/android_notification.dart';
import 'package:push_notification/src/notification/notificator/init_settings.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_notification.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';

/// Callback notification clicks
///
/// notificationData - notification data
typedef void OnNotificationTapCallback(Map notificationData);

/// Channels and methods names
const String CHANNEL_NAME = "surf_notification";
const String CALL_INIT = "initialize";
const String CALL_SHOW = "show";
const String CALL_REQUEST = "request";
const String CALLBACK_OPEN = "notificationOpen";

/// Arguments names
const String ARG_PUSH_ID = "pushId";
const String ARG_TITLE = "title";
const String ARG_BODY = "body";
const String ARG_DATA = "data";
const String ARG_NOTIFICATION_SPECIFICS = "notificationSpecifics";

/// Util for displaying notifications for android and ios
class Notificator {
  MethodChannel _channel = const MethodChannel(CHANNEL_NAME);
  IOSNotification _iosSurfNotification;
  AndroidNotification _androidSurfNotification;

  /// Callback notification clicks
  OnNotificationTapCallback onNotificationTapCallback;

  Notificator({
    @required InitSettings initSettings,
    this.onNotificationTapCallback,
  }) {
    _init(initSettings);
  }

  Future _init(InitSettings initSettings) async {
    if (Platform.isAndroid) {
      _androidSurfNotification = AndroidNotification(
        channel: _channel,
        onNotificationTap: (notificationData) =>
            onNotificationTapCallback(notificationData),
      );
      return _androidSurfNotification.init();
    } else if (Platform.isIOS) {
      _iosSurfNotification = IOSNotification(
        channel: _channel,
        onNotificationTap: (notificationData) {
          return onNotificationTapCallback(notificationData);
        },
      );
      return _iosSurfNotification.init(initSettings.iosInitSettings);
    }
  }

  /// Request notification permissions (iOS only)
  Future<bool> requestPermissions({
    bool requestSoundPermission = false,
    bool requestAlertPermission = false,
  }) async {
    if (Platform.isAndroid) return true;
    return _iosSurfNotification.requestPermissions(
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
    Map<String, String> data,
    NotificationSpecifics notificationSpecifics,
  }) async {
    if (Platform.isAndroid) {
      return _androidSurfNotification.show(
        id,
        title,
        body,
        data,
        notificationSpecifics.androidNotificationSpecifics,
      );
    } else if (Platform.isIOS) {
      return _iosSurfNotification.show(
        id,
        title,
        body,
        data,
        notificationSpecifics.iosNotificationSpecifics,
      );
    }
  }
}
