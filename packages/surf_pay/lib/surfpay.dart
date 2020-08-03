import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfpay/controller/payment_controller.dart';
import 'package:surfpay/data/apple_pay_data.dart';
import 'package:surfpay/data/apple_payment_request.dart';
import 'package:surfpay/data/google_pay_data.dart';
import 'package:surfpay/data/goole_payment_request.dart';
import 'package:surfpay/data/payment_item.dart';
import 'package:surfpay/ui/apple_button.dart';
import 'package:surfpay/ui/google_button.dart';

/// Widget to easy integrate apple/google pay
class Surfpay extends StatefulWidget {
  const Surfpay({
    Key key,
    this.customButton,
    this.buttonForceShow = false,
    this.googlePayData,
    this.applePayData,
    this.onSuccess,
    this.onCancel,
    this.onError,
    this.onPaymentTokenCallback,
  }) : super(key: key);

  /// Custom button builder
  final WidgetBuilder customButton;

  /// On success payment
  final SuccessCallback onSuccess;
  /// On user cancel payment
  final VoidCallback onCancel;
  /// On Error while payment
  final ErrorCallback onError;
  /// IOS callback to operate with token
  final ApplePayTokenCallback onPaymentTokenCallback;

  /// Google pay payment system information
  final GooglePayData googlePayData;
  /// Apple pay payment system information
  final ApplePayData applePayData;

  final bool buttonForceShow;

  @override
  State<StatefulWidget> createState() {
    return _SurfpayState();
  }
}

class _SurfpayState extends State<Surfpay> {
  PaymentController _paymentController;

  @override
  void initState() {
    super.initState();
    _paymentController = PaymentController(
      applePayData: widget.applePayData,
      googlePayData: widget.googlePayData,
      onSuccess: widget.onSuccess,
      onCancel: widget.onCancel,
      onError: widget.onError,
      onPaymentTokenCallback: widget.onPaymentTokenCallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _paymentController.isServiceAvailable(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox();
        }
        if (snapshot.data) {
          if (Platform.isAndroid) {
            return _buildAndroid();
          }
          return _buildApple();
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildAndroid() {
    if (widget.customButton == null) {
      return GoogleButton(
        onTap: () => _paymentController.pay(
          _exampleGoogleRequest,
          _exampleAppleRequest,
        ),
      );
    }
    return widget.customButton(context);
  }

  Widget _buildApple() {
    if (widget.customButton == null) {
      return AppleButton(
        onTap: () => _paymentController.pay(
          _exampleGoogleRequest,
          _exampleAppleRequest,
        ),
      );
    }
    return widget.customButton(context);
  }
}

final _exampleGoogleRequest = GooglePaymentRequest(
  '10.00',
  {
    'merchantName': 'Example Merchant',
  },
  true,
  ['RU', 'EN'],
  false,
  'RU',
  'RUB',
);

final _exampleAppleRequest = ApplePaymentRequest(
  [
    PaymentItem('IPhone', '60000.00', true),
  ],
  'RUB',
  'RU',
);
