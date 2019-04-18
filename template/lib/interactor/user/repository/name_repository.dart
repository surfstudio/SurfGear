import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/data/user_response.dart';
import 'package:flutter_template/util/const.dart';
import 'package:network/network.dart';

/// todo завернуть декодинг/энкодинг в json внутрь [Http]
class UserRepository {
  final Http http;

  UserRepository(this.http);

  Future<User> getUser() {
    return http
        .get(EMPTY_STRING) //todo реальный урл
        .then((r) => UserResponse.fromJson(r.body))
        .then((ur) => ur.transform());
  }
}
