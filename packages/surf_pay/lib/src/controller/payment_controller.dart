import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../data/apple_pay_data.dart';
import '../data/apple_payment_request.dart';
import '../data/google_pay_data.dart';
import '../data/goole_payment_request.dart';
import '../data/payment_status.dart';
import 'payment_utils.dart';

/// Channel
const String channelName = 'surfpay';

/// Methods
const String isReadyToPay = 'is_ready_to_pay';
const String payMethod = 'pay';
const String initMethod = 'init';

/// Payment result callbacks
const String onSuccessCallback = 'payment_success';
const String onCancelCallback = 'payment_cancel';
const String onErrorCallback = 'payment_error';

/// Return token for sending to server (IOS only)
const String onPaymentResultCallback = 'onPaymentResult';

/// Arguments
const String paymentErrorStatus = 'status';
const String onSuccessData = 'successData';
const String isTest = 'isTest';

const String paymentTokenData = 'paymentTokenData';
const String paymentTokenTransition = 'paymentTokenTransition';
const String paymentTokenNetwork = 'paymentTokenNetwork';

/// On success payment callback, payment data only on Android
typedef SuccessCallback = Function(Map<String, Object> paymentData);

/// On payment error callback
typedef ErrorCallback = Function(PaymentErrorStatus);

/// On payment token callback for IOS,
/// with arguments: data, transition, paymentMethodType
typedef ApplePayTokenCallback = Future<bool> Function(
  String,
  String,
  PaymentMethodType,
);

/// Controller to work with native
class PaymentController {
  PaymentController({
    @required this.googlePayData,
    @required this.applePayData,
    this.onSuccess,
    this.onCancel,
    this.onError,
    this.onPaymentTokenCallback,
    this.isTestEnvironment = true,
  })  : assert(googlePayData != null),
        assert(applePayData != null) {
    _initCallbackListener();
    _init(
      googlePayData,
      applePayData,
      isTestEnvironment,
    );
  }

  /// return payment token to confirm payment with ApplePay
  final ApplePayTokenCallback onPaymentTokenCallback;

  /// Google Pay immutable data
  final GooglePayData googlePayData;

  /// Apple Pay immutable data
  final ApplePayData applePayData;

  /// set test Environment on Android
  final bool isTestEnvironment;

  /// payment success callback
  final SuccessCallback onSuccess;

  /// payment cancel callback
  final VoidCallback onCancel;

  /// payment error callback
  final ErrorCallback onError;

  final MethodChannel _channel = const MethodChannel(channelName);

  void _init(
    GooglePayData googlePayData,
    ApplePayData applePayData,
    bool isTestEnvironment,
  ) {
    _channel.invokeMethod<void>(
      initMethod,
      <String, Object>{
        ...googlePayData.map(),
        ...applePayData.map(),
        isTest: isTestEnvironment,
      },
    );
  }

  void _initCallbackListener() {
    _channel.setMethodCallHandler(
      // ignore: missing_return
      (call) async {
        switch (call.method) {
          case onSuccessCallback:
            var paymentData = <String, Object>{};
            if (call.arguments[onSuccessData] != null) {
              paymentData = jsonDecode(
                call.arguments[onSuccessData] as String,
              ) as Map<String, Object>;
            }
            onSuccess?.call(paymentData);
            break;
          case onCancelCallback:
            onCancel?.call();
            break;
          case onErrorCallback:
            final errorStatus = call.arguments[paymentErrorStatus] as int;
            onError?.call(getPaymentErrorStatus(errorStatus));
            break;
          case onPaymentResultCallback:
            return onPaymentToken(call);
            break;
        }
      },
    );
  }

  /// adaptive pay method
  void pay(
      GooglePaymentRequest googleRequest, ApplePaymentRequest appleRequest) {
    if (Platform.isAndroid) {
      return _payGoogle(googleRequest);
    }
    return _payApple(appleRequest);
  }

  /// Checking if service enabled and paymentMethods enabled
  /// if true show button
  Future<bool> isServiceAvailable() {
    return _channel.invokeMethod(isReadyToPay);
  }

  /// callback for payment token, only IOS
  Future<bool> onPaymentToken(MethodCall call) {
    final params = call.arguments as Map<Object, Object>;

    final data = params[paymentTokenData] as String;
    final transition = params[paymentTokenTransition] as String;
    final PaymentMethodType methodType =
        PaymentMethodType.byValue(params[paymentTokenNetwork] as int);
    return onPaymentTokenCallback?.call(data, transition, methodType) ??
        Future.value(true);
  }

  void _payGoogle(GooglePaymentRequest request) {
    _channel.invokeMethod<void>(payMethod, request.map());
  }

  void _payApple(ApplePaymentRequest request) {
    _channel.invokeMethod<void>(payMethod, request.map());
  }
}
