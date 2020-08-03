import 'package:surfpay/data/payment_status.dart';

/// Transform RawValue to Error
PaymentErrorStatus getPaymentErrorStatus(int errorStatus) {
  switch (errorStatus) {
  // only Android
    case 0:
      return PaymentErrorStatus.resultSuccess;
    case 14:
      return PaymentErrorStatus.resultInterrupted;
    case 8:
      return PaymentErrorStatus.resultInternalError;
    case 15:
      return PaymentErrorStatus.resultTimeout;
    case 16:
      return PaymentErrorStatus.resultCanceled;
    case 18:
      return PaymentErrorStatus.resultDeadClient;
  // only IOS
    case 21:
      return PaymentErrorStatus.failPaymentController;
    case 22:
      return PaymentErrorStatus.iosPaymentError;
    default:
      return PaymentErrorStatus.unknown;
  }
}