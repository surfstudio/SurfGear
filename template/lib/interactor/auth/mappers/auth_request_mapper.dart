import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/base/mapper.dart';

class AuthRequestMapper extends Mapper<AuthInfo, Map<String, dynamic>> {

    AuthRequestMapper.of(AuthInfo data) : super.of(data);

    @override
    Map<String, dynamic> map() => {
        "phone": data.phone,
        "fcmToken": data.fcmToken
    };

}
