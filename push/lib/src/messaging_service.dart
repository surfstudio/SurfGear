import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push/push.dart';

enum MessageHandlerType { onMessage, onLaunch, onResume }

/// Wrapper over [FirebaseMessaging]
class MessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<String> get fcmTokenObservable => _messaging.getToken();

  HandleMessageFunction _handleMessage;

  /// request notification permissions for ios platform
  void requestNotificationPermissions() {
    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

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

  Future<dynamic> _internalMessageInterceptor(
    Map<String, dynamic> message,
    MessageHandlerType handlerType,
  ) async =>
      _handleMessage?.call(message, handlerType);
}
