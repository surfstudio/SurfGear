// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter_test/flutter_test.dart';
import 'package:otp_autofill/src/base/strategy.dart';
import 'package:otp_autofill/src/otp_text_edit_controller.dart';

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
