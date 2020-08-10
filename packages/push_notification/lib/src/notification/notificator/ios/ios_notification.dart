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

import 'package:flutter/services.dart';
import 'package:push_notification/src/notification/notificator/ios/ios_notification_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

/// Notifications for the ios platform
class IOSNotification {
  IOSNotification({
    this.channel,
    this.onNotificationTap,
    this.onPermissionDecline,
  });

  /// MethodChannel for connecting to ios native platform
  final MethodChannel channel;

  /// Callback notification push
  final OnNotificationTapCallback onNotificationTap;

  /// Callback notification decline
  final OnPermissionDeclineCallback onPermissionDecline;

  Future init() async {
    channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          case openCallback:
            if (onNotificationTap != null) {
              final notificationData = Map<String, Object>.of(
                call.arguments as Map<String, Object>,
              );
              onNotificationTap(notificationData);
            }
            break;
          case permissionDeclineCallback:
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
      callRequest,
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
    return channel.invokeMethod<dynamic>(
      callShow,
      <String, dynamic>{
        pushIdArg: id ?? 0,
        titleArg: title ?? '',
        bodyArg: body ?? '',
        imageUrlArg: imageUrl,
        dataArg: data,
      },
    );
  }
}
