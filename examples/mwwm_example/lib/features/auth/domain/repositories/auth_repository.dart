import 'package:mwwm_example/features/auth/domain/entities/auth_data.dart';

abstract class AuthRepository {
  String get accessToken;

  Future<AuthData> authenticate({
    required String login,
    required String password,
  });
}
