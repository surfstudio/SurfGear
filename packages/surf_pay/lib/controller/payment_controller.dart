import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:surfpay/controller/payment_utils.dart';
import 'package:surfpay/data/apple_pay_data.dart';
import 'package:surfpay/data/apple_payment_request.dart';
import 'package:surfpay/data/google_pay_data.dart';
import 'package:surfpay/data/goole_payment_request.dart';
import 'package:surfpay/data/payment_status.dart';

const String CHANNEL_NAME = "surfpay";
const String PAY_APPLE = "apple";

/// Methods
const String IS_READY_TO_PAY = "is_ready_to_pay";
const String PAY = "pay";
const String INIT = "init";

const String ON_SUCCESS = "payment_success";
const String ON_CANCEL = "payment_cancel";
const String ON_ERROR = "payment_error";

const String ON_PAYMENT_TOKEN = "onPaymentToken";
const String ON_PAYMENT_RESULT = "onPaymentResult";

/// Arguments
const String PAYMENT_ERROR_STATUS = "status";
const String ON_SUCCESS_DATA = "successData";

const String IS_TEST = "IS_TEST";

const String PAYMENT_TOKEN_DATA = "paymentTokenData";
const String PAYMENT_TOKEN_TRANSITION = "paymentTokenTransition";
const String PAYMENT_TOKEN_NETWORK = "paymentTokenNetwork";

const String IS_PAYMENT_SUCCESS = "isPaymentSuccess";

typedef SuccessCallback = Function(Map<String, dynamic> paymentData);
typedef ErrorCallback = Function(PaymentErrorStatus);

/// TODO replace bool with dynamic and send Errors?
typedef ApplePayTokenCallback = Future<bool> Function(
    String, String, PaymentMethodType);

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
        //todo
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

  final GooglePayData googlePayData;
  final ApplePayData applePayData;
  final bool isTestEnvironment;
  final SuccessCallback onSuccess;
  final VoidCallback onCancel;
  final ErrorCallback onError;

  MethodChannel _channel = MethodChannel(CHANNEL_NAME);

  void pay(
      GooglePaymentRequest googleRequest, ApplePaymentRequest appleRequest) {
    if (Platform.isAndroid) {
      return _payGoogle(googleRequest);
    }
    return _payApple(appleRequest);
  }

  void _init(
    GooglePayData googlePayData,
    ApplePayData applePayData,
    bool isTestEnvironment,
  ) {
    _channel.invokeMethod(INIT, {
      ...googlePayData.map(),
      ...applePayData.map(),
      IS_TEST: isTestEnvironment,
    });
  }

  void _initCallbackListener() {
    _channel.setMethodCallHandler(
      // ignore: missing_return
      (call) async {
        switch (call.method) {
          case ON_SUCCESS:
            var paymentData = Map<String, dynamic>();
            if (call.arguments[ON_SUCCESS_DATA] != null) {
              paymentData = jsonDecode(
                call.arguments[ON_SUCCESS_DATA] as String,
              );
            }
            onSuccess?.call(paymentData);
            break;
          case ON_CANCEL:
            onCancel?.call();
            break;
          case ON_ERROR:
            final errorStatus = call.arguments[PAYMENT_ERROR_STATUS] as int;
            onError?.call(getPaymentErrorStatus(errorStatus));
            break;
          case ON_PAYMENT_RESULT:
            return onPaymentToken(call);
            break;
        }
      },
    );
  }

  /// Checking if service enabled and paymentMethods enabled
  /// if true show button
  Future<bool> isServiceAvailable() {
    return _channel.invokeMethod(IS_READY_TO_PAY);
  }

  Future<bool> onPaymentToken(MethodCall call) {
    final params = call.arguments as Map<dynamic, dynamic>;

    final data = params[PAYMENT_TOKEN_DATA] as String;
    final transition = params[PAYMENT_TOKEN_TRANSITION] as String;
    final methodType =
        PaymentMethodType.byValue(params[PAYMENT_TOKEN_NETWORK] as int);
    return onPaymentTokenCallback?.call(data, transition, methodType) ??
        Future.value(true);
  }

  void _payGoogle(GooglePaymentRequest request) {
    _channel.invokeMethod(PAY, request.map());
  }

  void _payApple(ApplePaymentRequest request) {
    _channel.invokeMethod(PAY, request.map());
  }
}
