import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Strategy for sending logs to Crashlytics
class CrashlyticsRemoteLogStrategy extends RemoteUserLogStrategy {
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
      ..setUserIdentifier('')
      ..setUserName('')
      ..setUserEmail('');
  }

  @override
  void log(String message) {
    _crashlytics.log(message);
  }

  @override
  void logError(Exception error) {
    _crashlytics.recordError(
      error,
      FlutterErrorDetails(exception: error).stack,
    );
  }

  @override
  void logInfo(String key, info) {
    if (info is bool) {
      _crashlytics.setBool(key, info);
      return;
    }

    if (info is double) {
      _crashlytics.setDouble(key, info);
      return;
    }

    if (info is int) {
      _crashlytics.setInt(key, info);
      return;
    }

    if (info is String) {
      _crashlytics.setString(key, info);
    } else {
      _crashlytics.setString(key, info.toString());
    }
  }
}
