import 'package:flutter_template/interactor/base/network.dart';

class CustomErrorMapper extends ErrorMapper {

  @override
  mapError(e) {
    return e.toString();
  }

}