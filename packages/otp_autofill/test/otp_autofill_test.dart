import 'package:flutter_test/flutter_test.dart';
import 'package:otp_autofill/base/strategy.dart';
import 'package:otp_autofill/otp_text_edit_controller.dart';

const testCode = '54321';

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(milliseconds: 250),
      () => 'Your code is $testCode',
    );
  }
}

void main() {
  // This code binds the [TestWidgetsFlutterBinding]
  // to a [LiveTestWidgetsFlutterBinding],
  // which runs test code in a real async zone.
  LiveTestWidgetsFlutterBinding();

  late OTPTextEditController controller;

  setUp(() {
    controller = OTPTextEditController(
      codeLength: testCode.length,
      onCodeReceive: (code) {},
    )..startListenOnlyStrategies([SampleStrategy()], (code) {
        final exp = RegExp(r'(\d{5})');
        return exp.stringMatch(code ?? '') ?? '';
      });
  });

  testWidgets('OTPTextEditController startListenOnlyStrategies',
      (tester) async {
    expect(controller.text, isEmpty);

    await tester.pump(const Duration(milliseconds: 500));

    expect(controller.text, equals(testCode));
  });
}
