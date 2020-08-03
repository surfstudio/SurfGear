import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_edit_controller/base/strategy.dart';
import 'package:otp_text_edit_controller/impl/push_strategy.dart';
import 'package:otp_text_edit_controller/otp_interactor.dart';

class OTPTextEditController extends TextEditingController {
  OTPTextEditController() {
    _otpInteractor = OTPInteractor();
  }

  OTPInteractor _otpInteractor;

  void startListen(ExtractStringCallback codeExctractor,
      [List<OTPStrategy> strategies]) {
    _otpInteractor.startListen((rawSMS) {
      text = codeExctractor(rawSMS);
    });
  }
}
