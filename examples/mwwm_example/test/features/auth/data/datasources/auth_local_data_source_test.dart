import 'package:flutter_test/flutter_test.dart';
import 'package:mwwm_example/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mwwm_example/features/auth/data/models/auth_data_model.dart';

void main() {
  final authLocalDataSource = AuthLocalDataSourceImpl();

  test('Should successfully load authData', () async {
    final tAuthDataModel = AuthDataModel(
      accessToken: 'test_access_token',
    );

    final result = await authLocalDataSource.loadAuthData();

    expect(tAuthDataModel, result);
  });
}
