import 'package:flutter_template/interactor/base/network.dart';


/// StupidMapper
/// todo зарессерчить основные ошибки
class CustomErrorMapper extends ErrorMapper {

  @override
  mapError(e) {
    throw e;
  }

}