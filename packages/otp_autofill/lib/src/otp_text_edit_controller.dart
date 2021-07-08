// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otp_autofill/src/base/strategy.dart';
import 'package:otp_autofill/src/otp_interactor.dart';

/// Custom controller for text views, IOS autofill is built in flutter
class OTPTextEditController extends TextEditingController {
  OTPTextEditController({
    required this.codeLength,
    this.onCodeReceive,
    this.onTimeOutException,
    this.autoStop = true,
  }) {
    addListener(checkForComplete);
  }

  /// interaction with OTP
  final _otpInteractor = OTPInteractor();

  /// OTP code length - trigger for callback
  final int codeLength;

  /// [OTPTextEditController]'s receive OTP code callback
  final StringCallback? onCodeReceive;

  /// Receiver gets TimeoutError after 5 minutes without sms
  final VoidCallback? onTimeOutException;

  /// Stop listening after receiving or error an OTP code
  final bool autoStop;

  /// Start listen for OTP code with User Consent API
  /// sms by default
  /// could be added another input as [OTPStrategy]
  void startListenUserConsent(
    ExtractStringCallback codeExtractor, {
    List<OTPStrategy>? strategies,
    String? senderNumber,
  }) {
    final smsListen = _otpInteractor.startListenUserConsent(senderNumber);
    final strategiesListen = strategies?.map((e) => e.listenForCode());

    Stream.fromFutures([
      if (Platform.isAndroid) smsListen,
      if (strategiesListen != null) ...strategiesListen,
    ]).first.then((value) {
      if (autoStop) {
        stopListen();
      }
      text = codeExtractor(value);
      //ignore: avoid_types_on_closure_parameters
    }).catchError((Object _) {
      if (autoStop) {
        stopListen();
      }
      onTimeOutException?.call();
    });
  }

  /// Start listen for OTP code with Retriever API
  /// sms by default
  /// could be added another input as [OTPStrategy]
  void startListenRetriever(
    ExtractStringCallback codeExtractor, {
    List<OTPStrategy>? additionalStrategies,
  }) {
    final smsListen = _otpInteractor.startListenRetriever();
    final strategiesListen = additionalStrategies?.map(
      (e) => e.listenForCode(),
    );

    Stream.fromFutures([
      if (Platform.isAndroid) smsListen,
      if (strategiesListen != null) ...strategiesListen,
    ]).first.then((value) {
      if (autoStop) {
        stopListen();
      }
      text = codeExtractor(value);
      //ignore: avoid_types_on_closure_parameters
    }).catchError((Object _) {
      if (autoStop) {
        stopListen();
      }
      onTimeOutException?.call();
    });
  }

  /// Get OTP code from another input
  /// don't register any BroadcastReceivers
  void startListenOnlyStrategies(
    List<OTPStrategy>? strategies,
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
  Future<Object?> stopListen() {
    return _otpInteractor.stopListenForCode();
  }

  /// call onComplete callback if code entered
  void checkForComplete() {
    if (text.length == codeLength) onCodeReceive?.call(text);
  }
}
