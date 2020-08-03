import 'dart:async';

import 'package:flutter/services.dart';

class OtpTextEditController {
  static const MethodChannel _channel =
      const MethodChannel('otp_text_edit_controller');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
