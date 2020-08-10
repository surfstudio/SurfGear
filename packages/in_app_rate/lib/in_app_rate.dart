import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_rate/exception.dart';

/// Channel
const _channelName = 'in_app_rate';

/// Methods
const _openRatingDialog = 'openRatingDialog';

/// Arguments
const _isTestEnvironment = 'isTestEnvironment';

class InAppRate {
  static const MethodChannel _channel = MethodChannel(_channelName);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> openRatingDialog({
    bool isTest,
    VoidCallback onServiceError,
  }) {
    return _channel.invokeMethod<bool>(
      _openRatingDialog,
      <String, bool>{
        _isTestEnvironment: isTest,
      },
    ).catchError(
      (error) {
        if (onServiceError != null) {
          onServiceError();
          return false;
        } else {
          Platform.isAndroid
              ? throw PlayServiceNotEnabled()
              : throw IOVersionIsLow();
        }
      },
    );
  }
}
