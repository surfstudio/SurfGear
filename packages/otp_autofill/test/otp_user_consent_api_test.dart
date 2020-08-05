import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_user_consent_api/otp_interactor.dart';

void main() {
  const MethodChannel channel = MethodChannel('otp_autofill');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getTelephoneHint', () async {
    expect(await OTPInteractor.hint, null);
  });
}
