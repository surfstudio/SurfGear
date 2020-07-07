import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:surfpay/data/apple_pay_data.dart';
import 'package:surfpay/data/google_pay_data.dart';
import 'package:surfpay/data/payment_item.dart';
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

/// Arguments
const String PAYMENT_ERROR_STATUS = "status";
const String ON_SUCCESS_DATA = "successData";

const String PRICE = "price";
const String MERCHANT_INFO = "merchantInfo";
const String PHONE_NUMBER_REQUIRED = "phoneNumberRequired";
const String ALLOWED_COUNTRY_CODES = "allowedCountryCodes";
const String SHIPPING_ADDRESS_REQUIRED = "shippingAddressRequired";

const String IS_TEST = "IS_TEST";

const String ITEMS = "items";
const String COUNTRY_CODE = "countryCode";
const String CURRENCY_CODE = "currencyCode";

typedef SuccessCallback = Function(Map<String, dynamic> paymentData);
typedef ErrorCallback = Function(PaymentErrorStatus);

class PaymentController {
  PaymentController({
    @required this.googlePayData,
    @required this.applePayData,
    this.onSuccess,
    this.onCancel,
    this.onError,
    this.isTestEnvironment = true,
  }) : assert(googlePayData != null),
  //todo
        assert(applePayData != null) {
    _initCallbackListener();
    _init(
      googlePayData,
      applePayData,
      isTestEnvironment,
    );
  }

  final GooglePayData googlePayData;
  final ApplePayData applePayData;
  final bool isTestEnvironment;
  final SuccessCallback onSuccess;
  final VoidCallback onCancel;
  final ErrorCallback onError;

  MethodChannel _channel = MethodChannel(CHANNEL_NAME);

  void pay() {
    if (Platform.isAndroid) {
      return _payGoogle();
    }
    return _payApple();
  }

  void _init(GooglePayData googlePayData,
      ApplePayData applePayData,
      bool isTestEnvironment,) {
    _channel.invokeMethod(INIT, {
      ...googlePayData.map(),
      ...applePayData.map(),
      IS_TEST: isTestEnvironment,
    });
  }

  void _initCallbackListener() {
    _channel.setMethodCallHandler(
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
            onError?.call(_getPaymentErrorStatus(errorStatus));
            break;
        }
      },
    );
  }

  void _payGoogle() {
    final price = "120.00";
    final merchantInfo = {
      'merchantName': 'Example Merchant',
    };
    final phoneNumberRequired = true;
    final allowedCountryCodes = ["US", "GB"];
    final shippingAddressRequired = true;
    _channel.invokeMethod(
      PAY,
      <String, dynamic>{
        PRICE: price,
        MERCHANT_INFO: merchantInfo,
        PHONE_NUMBER_REQUIRED: phoneNumberRequired,
        ALLOWED_COUNTRY_CODES: allowedCountryCodes,
        SHIPPING_ADDRESS_REQUIRED: shippingAddressRequired
      },
    );
  }

  void _payApple() {
    final items = [
      PaymentItem(
        "IPhone",
        "60000.00",
        true,
      )
    ];
    _channel.invokeMethod(
      PAY,
      <String, dynamic>{
        ITEMS: items.map((e) => e.map()).toList(),
        CURRENCY_CODE: "RUB",
        COUNTRY_CODE: "RU"
      },
    );
  }

  Future<bool> googlePayIsAvalibale() {
    return _channel.invokeMethod(IS_READY_TO_PAY);
  }

  PaymentErrorStatus _getPaymentErrorStatus(int errorStatus) {
    switch (errorStatus) {
    // only Android
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
    // only IOS
      case 21:
        return PaymentErrorStatus.FAIL_PAYMENT_CONTROLLER;
      case 22:
        return PaymentErrorStatus.IOS_PAYMENT_ERROR;
      default:
        return PaymentErrorStatus.UNKNOWN;
    }
  }
}
