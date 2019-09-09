

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
