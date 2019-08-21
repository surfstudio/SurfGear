import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push/src/base/push_handle_strategy_factory.dart';
import 'package:push/src/notification/notification_controller.dart';
import 'package:rxdart/subjects.dart';

typedef Future<void> MessageHandler(Map<String, dynamic> message);

enum MessageHandlerType { OnTap, onMessage, onLaunch, onResume }

/// Обёртка над [FirebaseMessaging]
class PushManager {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  /// Возможность на прямую подписаться на получение пушей
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();

  final PushHandleStrategyFactory _strategyFactory;
  final NotificationController _notificationController;

  PushManager(
    this._strategyFactory,
    this._notificationController,
  ) {
    _initNotification();
  }

  Future<dynamic> _internalMessageInterceptor(
      Map<String, dynamic> message, MessageHandlerType handlerType) async {
    print("DEV_INFO receive message on $handlerType: $message");

    messageSubject.add(message);

    var strategy = _strategyFactory.createByData(message);
    return _notificationController.show(strategy);
  }

  void _initNotification() {
    _messaging.configure(
      onMessage: (message) =>
          _internalMessageInterceptor(message, MessageHandlerType.onMessage),
      onLaunch: (message) =>
          _internalMessageInterceptor(message, MessageHandlerType.onLaunch),
      onResume: (message) =>
          _internalMessageInterceptor(message, MessageHandlerType.onResume),
    );
  }

  void requestNotificationPermissions() {
    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
}
