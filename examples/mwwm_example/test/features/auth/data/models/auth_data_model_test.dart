import 'package:flutter_test/flutter_test.dart';
import 'package:mwwm_example/features/auth/data/models/auth_data_model.dart';

void main() {
  const tAuthDataModel = AuthDataModel(accessToken: 'test_access_token');

  test('Should be subclass of AuthData', () async {
    expect(tAuthDataModel, isA<AuthDataModel>());
  });

  test('Should return AuthDataModel from json', () async {
    final json = <String, dynamic>{
      'accessToken': 'test_access_token',
    };

    final result = AuthDataModel.fromJson(json);

    expect(tAuthDataModel, result);
  });
}
