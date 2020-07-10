import 'package:surfpay/data/payment_status.dart';

/// Transform RawValue to Error
PaymentErrorStatus getPaymentErrorStatus(int errorStatus) {
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