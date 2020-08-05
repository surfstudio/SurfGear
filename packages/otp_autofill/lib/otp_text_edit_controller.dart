import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otp_autofill/base/strategy.dart';
import 'package:otp_autofill/otp_interactor.dart';

/// Custom controller for text views, IOS autofill is built in flutter
class OTPTextEditController extends TextEditingController {
  OTPTextEditController({
    this.onCodeReceive,
    this.codeLength,
    this.onTimeOutException,
  }) : assert(onCodeReceive != null && codeLength != null ||
            onCodeReceive == null && codeLength == null) {
    if (onCodeReceive != null && codeLength != null) {
      addListener(checkForComplete);
    }
  }

  /// interaction with OTP
  final _otpInteractor = OTPInteractor();

  /// OTP code length - trigger for callback
  final int codeLength;

  /// OTPTextEditController receive OTP code
  final StringCallback onCodeReceive;

  /// Receiver get TimeoutError after 5 minutes without sms
  final VoidCallback onTimeOutException;

  /// Start listen for OTP code with User Consent API
  /// sms by default
  /// could be added another input as OTPStrategy
  void startListenUserConsent(
    ExtractStringCallback codeExtractor, {
    List<OTPStrategy> strategies,
    String senderNumber,
  }) {
    final smsListen = _otpInteractor.startListenUserConsent(senderNumber);
    final strategiesListen = strategies?.map((e) => e.listenForCode());

    Stream.fromFutures([
      if (Platform.isAndroid) smsListen,
      if (strategiesListen != null) ...strategiesListen,
    ]).first.then((value) {
      stopListen();
      text = codeExtractor(value);
    }).catchError((_) {
      stopListen();
      onTimeOutException?.call();
    });
  }

  /// Start listen for OTP code with Retriever API
  /// sms by default
  /// could be added another input as OTPStrategy
  void startListenRetriever(
    ExtractStringCallback codeExtractor, {
    List<OTPStrategy> strategies,
  }) {
    final smsListen = _otpInteractor.startListenRetriever();
    final strategiesListen = strategies?.map((e) => e.listenForCode());

    Stream.fromFutures([
      if (Platform.isAndroid) smsListen,
      if (strategiesListen != null) ...strategiesListen,
    ]).first.then((value) {
      stopListen();
      text = codeExtractor(value);
    }).catchError((_) {
      stopListen();
      onTimeOutException?.call();
    });
  }

  /// Get OTP code from another input
  /// don't registry BroadcastReceivers
  void startListenOnlyStrategies(
    List<OTPStrategy> strategies,
    ExtractStringCallback codeExtractor,
  ) {
    final strategiesListen = strategies?.map((e) => e.listenForCode());
    Stream.fromFutures([
      if (strategiesListen != null) ...strategiesListen,
    ]).first.then((value) {
      text = codeExtractor(value);
    });
  }

  /// Broadcast receiver stop listen for OTP code, use in dispose
  Future<dynamic> stopListen() {
    return _otpInteractor.stopListenForCode();
  }

  /// call onComplete callback if code entered
  void checkForComplete() {
    if (text.length == codeLength) onCodeReceive.call(text);
  }
}
