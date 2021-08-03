import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/features/auth/domain/entities/auth_data.dart';
import 'package:mwwm_example/features/auth/domain/usecases/authenticate_user.dart';
import 'package:mwwm_example/features/auth/presentation/wms/auth_screen_wm.dart';

import 'auth_screen_wm_test.mocks.dart';

@GenerateMocks([AuthenticateUser, NavigatorState])
void main() {
  final tAuthenticateUser = MockAuthenticateUser();
  final tAuthData = AuthData(accessToken: 'test_token');

  setUpAll(() {
    when(tAuthenticateUser.call(Params(
      login: 'test',
      password: 'test',
    ))).thenAnswer(
      (_) => Future.value(tAuthData),
    );
  });

  test(
    'Should successfully create widget model',
    () async {
      final wm = AuthScreenWidgetModel(
        WidgetModelDependencies(),
        authenticateUser: tAuthenticateUser,
        navigator: NavigatorState(),
      );

      wm.authenticate();
    },
  );

  test(
    'Should not create model and throw error',
    () async {
      when(tAuthenticateUser.call(Params(
        login: 'test',
        password: 'test',
      ))).thenAnswer(
        (_) => Future.value(tAuthData),
      );

      expect(
        () => tAuthenticateUser.call(Params(
          login: '',
          password: '',
        )),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
