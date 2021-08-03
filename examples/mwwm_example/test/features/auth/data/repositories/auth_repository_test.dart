import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwwm_example/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mwwm_example/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mwwm_example/features/auth/data/models/auth_data_model.dart';
import 'package:mwwm_example/features/auth/data/repositories/auth_repository_impl.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthLocalDataSourceImpl, AuthRemoteDataSourceImpl])
void main() {
  final authLocal = MockAuthLocalDataSourceImpl();
  final authRemote = MockAuthRemoteDataSourceImpl();
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemote,
    localDataSource: authLocal,
  );

  final tAuthDataModel = AuthDataModel(accessToken: 'test_123');

  setUpAll(() {
    when(authRemote.authenticate(
      password: 'test',
      login: 'test',
    )).thenAnswer(
      (_) => Future.value(tAuthDataModel),
    );
  });

  test('Should get authData', () async {
    final result =
        await authRepository.authenticate(login: 'test', password: 'test');

    verify(authRemote.authenticate(login: 'test', password: 'test')).called(1);

    expect(tAuthDataModel, result);
  });
}
