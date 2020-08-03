import 'dart:io';

import 'package:flutter/services.dart';

typedef StringCallback = void Function(String);

/// Methods
const getTelephoneHint = 'getTelephoneHint';
const startListenForCode = 'startListenForCode';

const onCodeCallback = 'onCodeCallback';

/// Arguments
const senderTelephoneNumber = 'senderTelephoneNumber';

/// Interact with native to get OTP code and telephone hint
class OTPInteractor {
  OTPInteractor() {
    _channel.setMethodCallHandler(methodCallHandler);
  }

  StringCallback codeCallback;

  static const MethodChannel _channel =
      MethodChannel('otp_text_edit_controller');

  /// Show user telephone picker and get chosen number
  static Future<String> get hint {
    if (Platform.isAndroid) {
      return _channel.invokeMethod(getTelephoneHint);
    } else {
      return Future.value('');
    }
  }

  /// Interaction with native part
  Future<dynamic> methodCallHandler(MethodCall call) {
    switch (call.method) {
      case onCodeCallback:
        receiveCode(call);
    }
  }

  /// BroadCast receiver start listen for OTP code
  Future<dynamic> startListen(
    StringCallback onCodeReceive, [
    String senderPhone,
  ]) async {
    codeCallback = onCodeReceive;
    if (Platform.isAndroid) {
      return _channel.invokeMethod<void>(
        startListenForCode,
        <String, String>{
          senderTelephoneNumber: senderPhone,
        },
      );
    } else {
      return null;
    }
  }

  /// Callback on code receive
  void receiveCode(MethodCall call) {
    final code = call.arguments as String;
    codeCallback?.call(code);
  }
}
