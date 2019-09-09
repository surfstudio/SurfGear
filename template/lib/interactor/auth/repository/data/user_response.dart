

import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/base/transformable.dart';
import 'package:flutter_template/util/const.dart';

/// Респонс на ответ сервера
///
/// Использовал [https://javiercbk.github.io/json_to_dart/] для генерации
class UserResponse implements Transformable<User> {
  String phone;
  String email;
  String accessToken;
  String fio;

  UserResponse({this.phone, this.email, this.accessToken});

  UserResponse.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    accessToken = json['accessToken'] ?? EMPTY_STRING;
    fio = json['fio'] ?? EMPTY_STRING;
  }

  @override
  User transform() => User(
        phone: phone,
        email: email,
        accessToken: accessToken,
        fio: fio,
      );
}
