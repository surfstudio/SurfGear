import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:surfpay/data/apple_pay_data.dart';
import 'package:surfpay/data/google_pay_data.dart';
import 'package:surfpay/data/payment_status.dart';

const String CHANNEL_NAME = "surfpay";
const String PAY_APPLE = "apple";

/// Methods
const String IS_READY_TO_PAY = "is_ready_to_pay";
const String PAY = "pay";
const String IS_READY_CALLBACK = "is_ready_to_pay";

const String ON_SUCCESS = "payment_success";
const String ON_CANCEL = "payment_cancel";
const String ON_ERROR = "payment_error";

/// Arguments
const String PAYMENT_ERROR_STATUS = "status";
const String ON_SUCCESS_DATA = "successData";

const String PRICE = "price";
const String MERCHANT_INFO = "merchantInfo";
const String PHONE_NUMBER_REQUIRED = "phoneNumberRequired";
const String ALLOWED_COUNTRY_CODES = "allowedCountryCodes";
const String SHIPPING_ADDRESS_REQUIRED = "shippingAddressRequired";

typedef SuccessCallback = Function(Map<String, dynamic> paymentData);
typedef ErrorCallback = Function(PaymentErrorStatus);

class PaymentController {
  PaymentController({
    this.googlePayData,
    this.applePayData,
    this.onSuccess,
    this.onCancel,
    this.onError,
  }) {
    _initCallbackListener();
  }

  final GooglePayData googlePayData;
  final ApplePayData applePayData;
  final SuccessCallback onSuccess;
  final VoidCallback onCancel;
  final ErrorCallback onError;

  MethodChannel _channel = MethodChannel(CHANNEL_NAME);

  void pay() {
    if (Platform.isAndroid) {
      return _payGoogle();
    }
    return _payApple(ApplePayData());
  }

  void _initCallbackListener() {
    _channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          case ON_SUCCESS:
            final paymentData = jsonDecode(
              call.arguments[ON_SUCCESS_DATA] as String,
            );
            onSuccess?.call(paymentData);
            break;
          case ON_CANCEL:
            onCancel?.call();
            break;
          case ON_ERROR:
            final errorStatus = call.arguments[PAYMENT_ERROR_STATUS] as int;
            onError?.call(_getPaymentErrorStatus(errorStatus));
            break;
        }
      },
    );
  }

  void _payGoogle() {
    _channel.invokeMethod(
      PAY,
      <String, dynamic>{
        "test_arg": "test",
      },
    );
  }

  void _payApple(ApplePayData data) {
    _channel.invokeMethod(
      PAY,
      <String, dynamic>{
        "test_arg": "test",
      },
    );
  }

  Future<bool> googlePayIsAvalibale(GooglePayData data) {
    return _channel.invokeMethod(IS_READY_TO_PAY, data.map());
  }

  PaymentErrorStatus _getPaymentErrorStatus(int errorStatus) {
    switch (errorStatus) {
      case 0:
        return PaymentErrorStatus.RESULT_SUCCESS;
      case 14:
        return PaymentErrorStatus.RESULT_INTERRUPTED;
      case 8:
        return PaymentErrorStatus.RESULT_INTERNAL_ERROR;
      case 15:
        return PaymentErrorStatus.RESULT_TIMEOUT;
      case 16:
        return PaymentErrorStatus.RESULT_CANCELED;
      case 18:
        return PaymentErrorStatus.RESULT_DEAD_CLIENT;
      default:
        return PaymentErrorStatus.UNKNOWN;
    }
  }
}
