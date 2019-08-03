import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/subjects.dart';

typedef Future<void> MessageHandler(Map<String, dynamic> message);

/// Обёртка над [FirebaseMessaging]
class PushManager {
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<String> get fcmTokenObservable => _messaging.getToken();

  void initNotification({
    MessageHandler onMessage,
    MessageHandler onLaunch,
    MessageHandler onResume,
  }) {
    final handle = (Map<String, dynamic> message, MessageHandler handler) {
      print("DEV_INFO receive message: $message");

      handler(message);
      messageSubject.add(message);
    };

    _messaging.configure(
      onMessage: (message) => handle(message, onMessage),
      onLaunch: (message) => handle(message, onLaunch),
      onResume: (message) => handle(message, onResume),
    );

    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
}
