import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwwm_example/features/auth/domain/entities/auth_data.dart';
import 'package:mwwm_example/features/auth/domain/repositories/auth_repository.dart';
import 'package:mwwm_example/features/auth/domain/usecases/authenticate_user.dart';

import 'authenticate_user_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  final tAuthRepository = MockAuthRepository();
  final tAuthenticateUser = AuthenticateUser(tAuthRepository);
  final tAuthData = AuthData(accessToken: 'test_token');

  setUpAll(() {
    when(tAuthRepository.authenticate(
      login: 'test',
      password: 'test',
    )).thenAnswer(
      (_) => Future.value(tAuthData),
    );
  });

  test('Should return auth data', () async {
    final result = await tAuthenticateUser.call(Params(
      login: 'test',
      password: 'test',
    ));

    expect(result, isA<AuthData>());
  });

  test('Should return test data', () async {
    final result = await tAuthenticateUser.call(Params(
      login: 'test',
      password: 'test',
    ));

    expect(result, tAuthData);
  });
}
