import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/features/auth/domain/entities/auth_data.dart';
import 'package:mwwm_example/features/auth/domain/usecases/authenticate_user.dart';
import 'package:mwwm_example/features/auth/presentation/wms/auth_screen_wm.dart';
import 'package:mwwm_example/features/home/presentation/screens/home_screen_route.dart';

import 'auth_screen_wm_test.mocks.dart';

@GenerateMocks([AuthenticateUser, NavigatorState])
void main() {
  final tAuthenticateUser = MockAuthenticateUser();
  final tNavigatorState = MockNavigatorState();
  final tAuthData = AuthData(accessToken: 'test_token');
  final wm = AuthScreenWidgetModel(
    WidgetModelDependencies(),
    authenticateUser: tAuthenticateUser,
    navigator: tNavigatorState,
  );

  setUpAll(() {
    when(tAuthenticateUser.call(Params(
      login: 'test',
      password: 'test',
    ))).thenAnswer(
      (_) => Future.value(tAuthData),
    );

    when(tNavigatorState.pushReplacement(HomeScreenRoute()))
        .thenAnswer((_) => Future.value());
  });

  test(
    'Should successfully map fields',
    () async {
      wm.passwordController.text = 'test123';
      wm.loginController.text = 'test424';
      await wm.authenticate();

      verify(tAuthenticateUser.call(Params(
        login: 'test424',
        password: 'test123',
      ))).called(1);
    },
  );

  test("Should throw error 'fill data exception'", () async {
    wm.passwordController.text = '';
    wm.loginController.text = '';

    await wm.authenticate();

    verifyNever(tAuthenticateUser.call(Params(
      login: '',
      password: '',
    )));
  });
}
