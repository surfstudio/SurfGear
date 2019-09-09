

import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/data/user_response.dart';
import 'package:flutter_template/util/const.dart';
import 'package:network/network.dart';
import 'package:rxdart/rxdart.dart';

///Репозиторий для работы с пользовательскими данными
class UserRepository {
  final RxHttp http;

  UserRepository(this.http);

  Observable<User> getUser() {
    return http
        .get(EMPTY_STRING) //todo реальный урл
        .map((r) => UserResponse.fromJson(r.body))
        .map((ur) => ur.transform());
  }
}
