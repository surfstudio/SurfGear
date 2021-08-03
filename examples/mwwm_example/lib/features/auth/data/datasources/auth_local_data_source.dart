import 'package:mwwm_example/features/auth/data/models/auth_data_model.dart';

abstract class AuthLocalDataSource {
  Future<AuthDataModel> loadAuthData();
  Future<void> saveAuthData(AuthDataModel authDataModel);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<AuthDataModel> loadAuthData() async {
    return Future.value(const AuthDataModel(accessToken: 'test_access_token'));
  }

  @override
  Future<void> saveAuthData(AuthDataModel authDataModel) async {
    return;
  }
}
