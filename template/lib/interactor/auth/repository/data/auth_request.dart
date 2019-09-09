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
import 'package:flutter_template/interactor/auth/mappers/auth_request_mapper.dart';

///Реквеcт модель для авторизации
class AuthRequest {
  String phone;
  String fcmToken;

  AuthRequest({this.phone, this.fcmToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['fcmToken'] = this.fcmToken;
    return data;
  }

  AuthRequest from(AuthInfo info) => AuthRequestMapper.of(info).map();
}
