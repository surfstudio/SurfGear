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
