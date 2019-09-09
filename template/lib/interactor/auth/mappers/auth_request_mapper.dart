

import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/data/auth_request.dart';
import 'package:flutter_template/interactor/base/mapper.dart';

/// Mapper из информации для авторизации в request
class AuthRequestMapper extends Mapper<AuthInfo, AuthRequest> {
  AuthRequestMapper.of(AuthInfo data) : super.of(data);

  @override
  AuthRequest map() => AuthRequest(phone: data.phone, fcmToken: data.fcmToken);
}
