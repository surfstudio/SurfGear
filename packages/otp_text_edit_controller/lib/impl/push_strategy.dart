import 'package:otp_text_edit_controller/base/strategy.dart';

typedef ExtractStringCallback = String Function(String);

/// Strategy if OTP code come from push
abstract class OTPPushStrategy extends OTPStrategy {
  OTPPushStrategy(this.extractCode);

  final ExtractStringCallback extractCode;

  @override
  Future<String> listenForCode();
}
