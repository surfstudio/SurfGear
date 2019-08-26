import 'package:flutter/foundation.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:logger/src/remote/strategies/remote_log_strategy.dart';

///Стратегия для отправки логов в Crashlytics
class CrashlyticsRemoteLogStrategy extends RemoteLogStrategy {
  FlutterCrashlytics get _crashlytics => FlutterCrashlytics();

  @override
  void setUser(String id, String username, String email) {
    _crashlytics.setUserInfo(id, email, username);
  }

  @override
  void clearUser() {
    _crashlytics.setUserInfo("", "","");
  }

  @override
  void log(String message) {
    _crashlytics.log(message);
  }

  @override
  void logError(dynamic error) {
    _crashlytics.onError(
      FlutterErrorDetails(
        exception: error,
      ),
    );
  }

  @override
  void logInfo(String key, info) {
    _crashlytics.setInfo(key, info);
  }
}
