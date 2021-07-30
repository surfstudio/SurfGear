import 'package:mwwm_example/features/auth/data/models/auth_data_model.dart';

//Здесь и везде на уровне datasource можно обойтись без абстрактного класа.
//Но тогда будет не по фэншую))
abstract class AuthRemoteDataSource {
  Future<AuthDataModel> authenticate({
    required String login,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthDataModel> authenticate({
    required String login,
    required String password,
  }) async {
    //Логика отправки данных аутентификации на сервер и получение токена
    return Future.delayed(
      const Duration(seconds: 2),
      () => const AuthDataModel(accessToken: 'test_access_token'),
    );
  }
}
