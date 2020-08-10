import 'dart:async';

import 'package:flutter/services.dart';

/// Channel
const _channelName = 'in_app_rate';

/// Methods
const _openRatingDialog = 'openRatingDialog';

class InAppRate {
  static const MethodChannel _channel = const MethodChannel(_channelName);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> openRationDialog() {
    return _channel.invokeMethod(_openRatingDialog);
  }
}
