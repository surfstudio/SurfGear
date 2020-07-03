import 'dart:io';

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
const String PAYMENT_STATUS = "status";

const String PRICE = "price";
const String MERCHANT_INFO = "merchantInfo";
const String PHONE_NUMBER_REQUIRED = "phoneNumberRequired";
const String ALLOWED_COUNTRY_CODES = "allowedCountryCodes";
const String SHIPPING_ADDRESS_REQUIRED = "shippingAddressRequired";

class PaymentController {
  PaymentController({
    this.googlePayData,
    this.applePayData,
    this.paymentCallback,
  }) {
    _initCallbackListener();
  }

  final GooglePayData googlePayData;
  final ApplePayData applePayData;
  final Function(PaymentStatus status) paymentCallback;

  MethodChannel _channel = MethodChannel(CHANNEL_NAME);

  void pay() {
    if (Platform.isAndroid) {
      return _payGoogle();
    }
    return _payApple(ApplePayData());
  }

  void _initCallbackListener() {
//    _channel.setMethodCallHandler(
//      (call) async {
//        switch (call.method) {
//          case PAYMENT_RESPONSE:
//            String status = call.arguments;
//
//            //todo заменить на реальный парсинг статуса оплаты
//            print("статус оплаты: $status");
//            paymentCallback(status == "success"
//                ? PaymentStatus.success
//                : PaymentStatus.fail);
//            break;
//          case IS_READY_TO_PAY:
//            bool isReadyToPay = call.arguments;
//            print("к оплате готов $isReadyToPay");
//            break;
//        }
//      },
//    );
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
}
