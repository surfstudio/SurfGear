import 'package:mwwm_example/features/auth/data/models/auth_data_model.dart';

//Здесь и везде на уровне datasource можно обойтись без абстрактного класа.
//Но тогда будет не по фэншую))
abstract class AuthLocalDataSource {
  Future<AuthDataModel> loadAuthData();
  Future<void> saveAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<AuthDataModel> loadAuthData() async {
    //Логика загрузки данных из памяти устройства
    return Future.value(const AuthDataModel(accessToken: 'test_access_token'));
  }

  @override
  Future<void> saveAuthData() async {
    //Логика сохранения токена память
  }
}
