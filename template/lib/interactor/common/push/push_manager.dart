import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

/// Обёртка над [FirebaseMessaging]
class PushManager {
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<String> get fcmTokenObservable => _messaging.getToken();

  void initNotification(onMessage(Map<String, dynamic> message)) {
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print("DEV_INFO receive message: $message");

        onMessage(message);
        messageSubject.add(message);
      },
    );

    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
}
