import 'package:flutter_template/util/const.dart';
import 'package:string_mask/string_mask.dart';

/// Пользователь
class User {
  final String phone;
  final String email;
  final String accessToken;
  final String fio;

  final StringMask _mask = StringMask("+0 (000) 000 00 00");

  User({
    this.phone,
    this.email,
    this.accessToken,
    this.fio,
  });


  String get formattedPhone {
    String res = _mask.apply(phone.replaceAll("+", "")); //убираем +
    return res;
  }
}

/// Информация, необходимая для авторизации
class AuthInfo {
  final String phone;
  final String fcmToken;

  AuthInfo({this.phone, this.fcmToken = EMPTY_STRING});
}
