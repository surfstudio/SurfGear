import 'package:otp_user_consent_api/impl/push_strategy.dart';

class SampleStrategy extends OTPPushStrategy {
  SampleStrategy(ExtractStringCallback extractCode) : super(extractCode);

  @override
  Future<String> listenForCode() {
    // TODO: implement listenForCode
    throw UnimplementedError();
  }
}
