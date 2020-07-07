import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfpay/controller/payment_controller.dart';
import 'package:surfpay/data/google_pay_data.dart';
import 'package:surfpay/ui/apple_button.dart';
import 'package:surfpay/ui/google_button.dart';

import 'data/apple_pay_data.dart';

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
  }) : super(key: key);

  final Function(BuildContext context, VoidCallback pay) customButton;
  final SuccessCallback onSuccess;
  final VoidCallback onCancel;
  final ErrorCallback onError;

  final GooglePayData googlePayData;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return _buildAndroid();
    }
    return _buildApple();
  }

  Widget _buildAndroid() {
    Widget _buildGoogleButton() {
      if (widget.customButton == null) {
        return GoogleButton(
          onTap: () => _paymentController.pay(),
        );
      }
      return widget.customButton(
        context,
        _paymentController.pay,
      );
    }

    test();
    if (true) {
      return _buildGoogleButton();
    }
    if (widget.buttonForceShow) {
      return _buildGoogleButton();
    }
    return SizedBox();
  }

  Widget _buildApple() {
    test();
    if (widget.customButton == null) {
      return AppleButton(onTap: () => _paymentController.pay());
    }
    return widget.customButton(
      context,
      _paymentController.pay,
    );
  }

  Future<void> test() async {
    final a = await _paymentController.googlePayIsAvalibale();
    print(a);
  }
}
