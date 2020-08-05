

import 'dart:io';

import 'package:flutter/services.dart';

typedef StringCallback = void Function(String);

/// Channel
const channelName = 'otp_surfstudio';

/// Methods
const getTelephoneHint = 'getTelephoneHint';
const startListenUserConsentMethod = 'startListenUserConsent';
const startListenRetrieverMethod = 'startListenRetriever';
const stopListenForCodeMethod = 'stopListenForCode';
const getAppSignatureMethod = 'getAppSignature';

/// Arguments
const senderTelephoneNumber = 'senderTelephoneNumber';

/// Interact with native to get OTP code and telephone hint
class OTPInteractor {
  static const MethodChannel _channel = MethodChannel(channelName);

  /// Show user telephone picker and get chosen number
  static Future<String> get hint {
    if (Platform.isAndroid) {
      return _channel.invokeMethod(getTelephoneHint);
    } else {
      return Future.value(null);
    }
  }

  /// Get app signature, that used in Retriever API
  static Future<String> getAppSignature() async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod(getAppSignatureMethod);
    } else {
      return null;
    }
  }

  /// Broadcast receiver stop listen for OTP code, use in dispose
  Future<dynamic> stopListenForCode() {
    return _channel.invokeMethod<dynamic>(stopListenForCodeMethod);
  }

  /// Broadcast receiver start listen for OTP code with User Consent API
  Future<String> startListenUserConsent([String senderPhone]) async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod<String>(
        startListenUserConsentMethod,
        <String, String>{
          senderTelephoneNumber: senderPhone,
        },
      );
    } else {
      return null;
    }
  }

  /// Broadcast receiver start listen for OTP code with Retriever API
  Future<String> startListenRetriever() async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod<String>(startListenRetrieverMethod);
    } else {
      return null;
    }
  }
}
