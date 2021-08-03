import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwwm_example/features/auth/presentation/screens/auth_screen.dart';
import 'package:mwwm_example/features/auth/presentation/wms/auth_screen_wm.dart';

import 'auth_screen_test.mocks.dart';

@GenerateMocks([AuthScreenWidgetModel])
void main() {
  final authScreenWM = MockAuthScreenWidgetModel();

  setUpAll(() async {
    when(authScreenWM.loginController)
        .thenAnswer((realInvocation) => TextEditingController());
    when(authScreenWM.passwordController)
        .thenAnswer((realInvocation) => TextEditingController());
  });

  testGoldens('AuthScreen goldens', (tester) async {
    when(authScreenWM.isLoading)
        .thenAnswer((realInvocation) => Stream.value(false));

    await tester.pumpWidgetBuilder(AuthScreen(
      widgetModelBuilder: (context) => authScreenWM,
    ));
    await multiScreenGolden(tester, 'auth_screen');
  });
}
