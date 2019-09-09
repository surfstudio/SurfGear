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
