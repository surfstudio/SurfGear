import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/src/remote/strategies/remote_log_strategy.dart';

///Стратегия для отправки логов в Crashlytics
class CrashlyticsRemoteLogStrategy extends RemoteLogStrategy {
  Crashlytics get _crashlytics => Crashlytics.instance;

  @override
  void setUser(String id, String username, String email) {
    _crashlytics
      ..setUserIdentifier(id)
      ..setUserName(username)
      ..setUserEmail(email);
  }

  @override
  void clearUser() {
    _crashlytics
      ..setUserIdentifier("")
      ..setUserName("")
      ..setUserEmail("");
  }

  @override
  void log(String message) {
    _crashlytics.log(message);
  }

  @override
  void logError(Exception error) {
    _crashlytics.onError(FlutterErrorDetails(
      exception: error,
    ));
  }

  @override
  void logInfo(String key, info) {
    _crashlytics.setInt(key, info);
  }
}
