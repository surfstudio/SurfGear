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

import 'dart:collection';

import 'package:push_notification/src/base/push_handle_strategy.dart';
import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

typedef NotificationCallback = void Function(Map<String, dynamic> payload);

const String pushIdParam = 'localPushId';

/// Wrapper over surf notifications
class NotificationController {
  NotificationController(OnPermissionDeclineCallback onPermissionDecline) {
    _notificator = Notificator(
      onNotificationTapCallback: _internalOnSelectNotification,
      onPermissionDecline: onPermissionDecline,
    );
  }

  Notificator _notificator;

  Map<int, NotificationCallback> callbackMap =
      HashMap<int, NotificationCallback>();

  /// Request notification permissions (iOS only)
  Future<bool> requestPermissions() {
    return _notificator.requestPermissions(
      requestSoundPermission: true,
      requestAlertPermission: true,
    );
  }

  /// displaying notification from the strategy
  Future<dynamic> show(
    PushHandleStrategy strategy,
    NotificationCallback onSelectNotification,
  ) {
    final androidSpecifics = AndroidNotificationSpecifics(
      channelId: strategy.notificationChannelId,
      channelName: strategy.notificationChannelName,
      autoCancelable: strategy.autoCancelable,
      color: strategy.color,
      icon: strategy.icon,
    );

    final platformSpecifics = NotificationSpecifics(androidSpecifics);

    // ignore: avoid_print
    print(
      'DEV_INFO receive for show push : ${strategy.payload.title}, '
      '${strategy.payload.body}',
    );

    final int pushId = DateTime.now().millisecondsSinceEpoch;

    final Map<String, String> tmpPayload = strategy.payload.messageData.map(
      // ignore: avoid_types_on_closure_parameters
      (key, Object value) => MapEntry(
        key.toString(),
        value.toString(),
      ),
    );

    tmpPayload[pushIdParam] = '$pushId';
    callbackMap[pushId] = onSelectNotification;

    return _notificator.show(
      strategy.pushId,
      strategy.payload.title,
      strategy.payload.body,
      imageUrl: strategy.payload.imageUrl,
      data: tmpPayload,
      notificationSpecifics: platformSpecifics,
    );
  }

  Future<dynamic> _internalOnSelectNotification(Map payload) async {
    // ignore: avoid_print
    print('DEV_INFO onSelectNotification, payload: $payload');

    final tmpPayload = payload as Map<String, String>;
    final int pushId = int.parse(tmpPayload[pushIdParam]);
    final onSelectNotification = callbackMap[pushId];
    callbackMap.remove(pushId);

    return onSelectNotification?.call(tmpPayload);
  }
}
