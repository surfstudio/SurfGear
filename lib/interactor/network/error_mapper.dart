import 'dart:convert' as json;

import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:network/network.dart';

/// StupidMapper
/// todo зарессерчить основные ошибки
class CustomErrorMapper extends ErrorMapper {
  @override
  mapError(e) {
    ErrorResponse er;

    //todo смаппить основные ршибки сервера в проекте
    try {
      er = ErrorResponse.fromJson(json.jsonDecode(e));
      switch (er.errorCode) {
        case 101:
          throw OtpException();
        case 102:
          throw UserNotFoundException();
        case 105:
          throw NotFoundException(er.message);
        default:
          throw Exception("Another exception");
      }
    } catch (ex) {
      throw ex;
    }
  }
}

/// Респонс с ошибкой
class ErrorResponse {
  int errorCode;
  String message;

  ErrorResponse({this.errorCode, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }
}
