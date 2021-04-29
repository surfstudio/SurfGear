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

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_demo/utils/logger.dart';
import 'package:push_notification/push_notification.dart';

/// Wrapper over [FirebaseMessaging]
class MessagingService extends BaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late HandleMessageFunction _handleMessage;

  Future<String?> get fcmToken => _messaging.getToken();

  final List<String> _topicsSubscription = [];

  /// request notification permissions for ios platform
  void requestNotificationPermissions() {
    _messaging.requestPermission();
  }

  /// no need to call. initialization is called inside the [PushHandler]
  @override
  void initNotification(HandleMessageFunction handleMessage) {
    _handleMessage = handleMessage;
    FirebaseMessaging.onMessage.listen(
      (message) => _internalMessageInterceptor(
        message.data,
        MessageHandlerType.onMessage,
      ),
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        _internalMessageInterceptor(
          message.data,
          MessageHandlerType.onLaunch,
        );
      },
    );
    FirebaseMessaging.onBackgroundMessage(
      (message) => _internalMessageInterceptor(
        message.data,
        MessageHandlerType.onResume,
      ),
    );
  }

  /// subscribe to [topic] in background.
  void subscribeToTopic(String topic) {
    _messaging.subscribeToTopic(topic);
    _topicsSubscription.add(topic);
  }

  /// subscribe on a list of [topics] in background.
  void subscribeToTopics(List<String> topics) {
    topics.forEach(subscribeToTopic);
  }

  /// unsubscribe from [topic] in background1.
  void unsubscribeFromTopic(String topic) {
    _messaging.unsubscribeFromTopic(topic);
    _topicsSubscription.remove(topic);
  }

  /// unsubscribe from [topics]
  void unsubscribeFromTopics(List<String> topics) {
    topics.forEach(unsubscribeFromTopic);
  }

  /// unsubscribe from all topics
  void unsubscribe() {
    _topicsSubscription.forEach(unsubscribeFromTopic);
  }

  Future<dynamic> _internalMessageInterceptor(
    Map<String, dynamic> message,
    MessageHandlerType handlerType,
  ) async {
    logger.d('FIREBASE MESSAGE: $handlerType - $message');
    _handleMessage.call(message, handlerType);
  }
}
