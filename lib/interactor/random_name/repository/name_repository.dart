import 'dart:convert' as json;

import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/base/network.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/random_name/repository/data/user.dart';

/// todo завернуть декодинг/энкодинг в json внутрь [Http]
class UserRepository {
  final Http http;

  UserRepository(this.http);

  Future<User> getUser() {
    return http
        .get(randomNameUrl)
        .then((r) => UserResponse.fromJson(json.jsonDecode(r.body)))
        .then((ur) => ur.transform());
  }
}
