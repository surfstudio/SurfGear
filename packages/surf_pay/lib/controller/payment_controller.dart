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
const String GATEWAY = "gateway";
const String GATEWAY_MERCHANT_ID = "gatewayMerchantId";
const String GATEWAY_TYPE = "gatewayType";

typedef SuccessCallback = Function(Map<String, dynamic> paymentData);
typedef ErrorCallback = Function(PaymentErrorStatus);

class PaymentController {
  PaymentController({
    @required this.googlePayData,
    @required this.applePayData,
    @required String gateway,
    @required String gatewayMerchantId,
    @required String gatewayType,
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
      gateway,
      gatewayMerchantId,
      gatewayType,
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
    return _payApple(ApplePayData());
  }

  void _init(GooglePayData googlePayData,
      ApplePayData applePayData,
      bool isTestEnvironment,
      String gateway,
      String gatewayMerchantId,
      String gatewayType,) {
    _channel.invokeMethod(INIT, {
      ...googlePayData.map(),
      ...applePayData.map(),
      IS_TEST: isTestEnvironment,
      GATEWAY: gateway,
      GATEWAY_MERCHANT_ID: gatewayMerchantId,
      GATEWAY_TYPE: gatewayType,
    });
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

  void _payApple(ApplePayData data) {
    _channel.invokeMethod(
      PAY,
      <String, dynamic>{
        "test_arg": "test",
      },
    );
  }

  Future<bool> googlePayIsAvalibale() {
    return _channel.invokeMethod(IS_READY_TO_PAY);
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
