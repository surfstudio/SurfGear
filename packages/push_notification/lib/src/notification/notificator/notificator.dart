// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/android/android_notification.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_notification.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';

/// Callback notification clicks
///
/// notificationData - notification data
typedef OnNotificationTapCallback = void Function(Map notificationData);

/// Callback permission decline
typedef OnPermissionDeclineCallback = void Function();

/// Channels and methods names
const String channelName = 'surf_notification';
const String callInit = 'initialize';
const String callShow = 'show';
const String callRequest = 'request';
const String openCallback = 'notificationOpen';
const String permissionDeclineCallback = 'permissionDecline';

/// Arguments names
const String pushIdArg = 'pushId';
const String titleArg = 'title';
const String bodyArg = 'body';
const String imageUrlArg = 'imageUrl';
const String dataArg = 'data';
const String notificationSpecificsArg = 'notificationSpecifics';

/// Util for displaying notifications for android and ios
class Notificator {
  Notificator({
    required this.onNotificationTapCallback,
    this.onPermissionDecline,
  }) {
    _init();
  }

  static const _channel = MethodChannel(channelName);
  late IOSNotification _iosNotification;
  late AndroidNotification _androidNotification;

  /// Callback notification clicks
  final OnNotificationTapCallback onNotificationTapCallback;

  /// Callback notification decline(ios only)
  final OnPermissionDeclineCallback? onPermissionDecline;

  Future _init() async {
    if (Platform.isAndroid) {
      _androidNotification = AndroidNotification(
        channel: _channel,
        onNotificationTap: onNotificationTapCallback,
      );

      return _androidNotification.init();
    } else if (Platform.isIOS) {
      _iosNotification = IOSNotification(
        channel: _channel,
        onNotificationTap: onNotificationTapCallback,
        onPermissionDecline: onPermissionDecline,
      );

      return _iosNotification.init();
    }
  }

  /// Request notification permissions (iOS only)
  Future<bool?> requestPermissions({
    bool? requestSoundPermission,
    bool? requestAlertPermission,
  }) {
    if (Platform.isAndroid) {
      return Future.value(true);
    }

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
    String? imageUrl,
    Map<String, String>? data,
    NotificationSpecifics? notificationSpecifics,
  }) {
    if (Platform.isAndroid) {
      return _androidNotification.show(
        id,
        title,
        body,
        imageUrl,
        data,
        notificationSpecifics!.androidNotificationSpecifics,
      );
    } else if (Platform.isIOS) {
      return _iosNotification.show(
        id,
        title,
        body,
        imageUrl,
        data,
        notificationSpecifics!.iosNotificationSpecifics,
      );
    }

    return Future<void>.value();
  }
}
