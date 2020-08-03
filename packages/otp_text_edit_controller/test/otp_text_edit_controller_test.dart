import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_text_edit_controller/otp_text_edit_controller.dart';

void main() {
  const MethodChannel channel = MethodChannel('otp_text_edit_controller');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OtpTextEditController.platformVersion, '42');
  });
}
