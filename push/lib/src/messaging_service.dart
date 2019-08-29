import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push/push.dart';

enum MessageHandlerType { onMessage, onLaunch, onResume }

/// Wrapper over [FirebaseMessaging]
class MessagingService {
  MessagingService(
    this._handler,
  ) {
    _initNotification();
  }

  final FirebaseMessaging _messaging = FirebaseMessaging();

  final PushHandler _handler;

  /// request notification permissions for ios platform
  void requestNotificationPermissions() {
    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  Future<dynamic> _internalMessageInterceptor(
    Map<String, dynamic> message,
    MessageHandlerType handlerType,
  ) async =>
      _handler.messageHandler(message, handlerType);

  void _initNotification() {
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
}
