/// Error while payment
enum PaymentErrorStatus {
  /// Android Errors
  resultSuccess,
  resultInterrupted,
  resultInternalError,
  resultTimeout,
  resultCanceled,
  resultDeadClient,
  
  /// IOS Errors

  /// Can't show payment sheet
  failPaymentController,

  /// error
  iosPaymentError,
  unknown,
}
