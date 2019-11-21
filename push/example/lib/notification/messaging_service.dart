import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push/push.dart';

/// Wrapper over [FirebaseMessaging]
class MessagingService extends BaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<String> get fcmTokenObservable => _messaging.getToken();

  HandleMessageFunction _handleMessage;

  /// request notification permissions for ios platform
  void requestNotificationPermissions() {
    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  /// no need to call. initialization is called inside the [PushHandler]
  void initNotification(HandleMessageFunction handleMessage) {
    this._handleMessage = handleMessage;
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

  /// subscribe to topic in background.
  void subscribeToTopic(String topic) {
    _messaging.subscribeToTopic(topic);
  }

  /// subscribe on a list of topics in background.
  void subscribeToTopics(List<String> topics) {
    topics.forEach(subscribeToTopic);
  }

  Future<dynamic> _internalMessageInterceptor(
    Map<String, dynamic> message,
    MessageHandlerType handlerType,
  ) async =>
      _handleMessage?.call(message, handlerType);
}
