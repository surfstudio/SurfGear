import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/base/transformable.dart';

///Реквеcт модель для авторизации
class AuthRequest implements Creator<AuthInfo> {
  String phone;
  String fcmToken;

  AuthRequest({this.phone, this.fcmToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['fcmToken'] = this.fcmToken;
    return data;
  }

  @override
  AuthRequest from(AuthInfo info) =>
      AuthRequest(phone: info.phone, fcmToken: info.fcmToken);
}
