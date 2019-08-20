import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push/src/push_handle_strategy.dart';
import 'package:push/src/push_handle_strategy_factory.dart';
import 'package:rxdart/subjects.dart';

typedef Future<void> MessageHandler(Map<String, dynamic> message);

/// Обёртка над [FirebaseMessaging]
class PushManager {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  /// Возможность на прямую подписаться на получение пушей
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();

  final PushHandleStrategyFactory _strategyFactory;

  PushManager(this._strategyFactory) {
    _initNotification();
  }

  Future<String> get fcmTokenObservable => _messaging.getToken();

  /// Создание стратегии по данным из интента.
  /// @param data данные из нотификации
  PushHandleStrategy createStrategy(Map<String, dynamic> data) =>
      _strategyFactory.createByData(data);

  _internalMessageInterceptor(
      Map<String, dynamic> message, MessageHandlerType handlerType) {
    print("DEV_INFO receive message on $handlerType: $message");

    var strategy = createStrategy(message);
    strategy.handleMessage(message, handlerType);

    messageSubject.add(message);
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

    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
}

enum MessageHandlerType { onMessage, onLaunch, onResume }
