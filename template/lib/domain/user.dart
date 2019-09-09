/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

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

  //убираем +
  String get formattedPhone => _mask.apply(phone.replaceAll("+", ""));
}

/// Информация, необходимая для авторизации
class AuthInfo {
  final String phone;
  final String fcmToken;

  AuthInfo({this.phone, this.fcmToken = EMPTY_STRING});
}
