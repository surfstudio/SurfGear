import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:surf_logger/logger.dart';
import 'package:push_notification/push_notification.dart';

/// Wrapper over [FirebaseMessaging]
class MessagingService extends BaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<String> get fcmToken => _messaging.getToken();

  HandleMessageFunction _handleMessage;
  final List<String> _topicsSubscription = [];

  /// request notification permissions for ios platform
  void requestNotificationPermissions() {
    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(),
    );
  }

  /// no need to call. initialization is called inside the [PushHandler]
  @override
  void initNotification(HandleMessageFunction handleMessage) {
    _handleMessage = handleMessage;
    _messaging.configure(
      onMessage: (message) => _internalMessageInterceptor(
        message,
        MessageHandlerType.onMessage,
      ),
      onLaunch: (message) => _internalMessageInterceptor(
        message,
        MessageHandlerType.onLaunch,
      ),
      onResume: (message) => _internalMessageInterceptor(
        message,
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
    Logger.d('FIREBASE MESSAGE: $handlerType - $message');
    _handleMessage?.call(message, handlerType);
  }
}
