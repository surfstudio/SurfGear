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

import 'package:push_notification/push_notification.dart';
import 'package:push_notification/src/base/base_messaging_service.dart';
import 'package:push_notification/src/base/push_handle_strategy_factory.dart';
import 'package:push_notification/src/notification/notification_controller.dart';
import 'package:push_notification/src/push_navigator_holder.dart';
import 'package:rxdart/subjects.dart';

typedef HandleMessageFunction = void Function(
  Map<String, dynamic> message,
  MessageHandlerType handlerType,
);

/// Notification handling
class PushHandler {
  PushHandler(
    this._strategyFactory,
    this._notificationController,
    this._messagingService,
  ) {
    _messagingService.initNotification(handleMessage);
  }

  /// The ability to directly subscribe to receive messages
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final BehaviorSubject<PushHandleStrategy> selectNotificationSubject =
      BehaviorSubject();

  final PushHandleStrategyFactory _strategyFactory;
  final NotificationController _notificationController;
  final BaseMessagingService _messagingService;

  /// request permission for show notification
  /// soundPemission - is play sound
  /// alertPermission - is show alert
  Future<bool?> requestPermissions({
    bool? soundPemission,
    bool? alertPermission,
  }) {
    return _notificationController.requestPermissions(
      requestSoundPermission: soundPemission,
      requestAlertPermission: alertPermission,
    );
  }

  /// display local notification
  /// MessagingService calls this method to display the notification that
  /// came from message service
  void handleMessage(
    Map<String, dynamic> message,
    MessageHandlerType handlerType, {
    bool localNotification = false,
  }) {
    if (!localNotification) {
      messageSubject.add(message);
    }

    final strategy = _strategyFactory.createByData(message);

    if (handlerType == MessageHandlerType.onLaunch ||
        handlerType == MessageHandlerType.onResume) {
      strategy.onBackgroundProcess(message);
    }

    if (handlerType == MessageHandlerType.onMessage) {
      _notificationController.show(
        strategy,
        (_) {
          selectNotificationSubject.add(strategy);
          strategy.onTapNotification(PushNavigatorHolder().navigator);
        },
      );
    }
  }
}
