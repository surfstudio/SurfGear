// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:name_generator/interactor/common/exceptions.dart';
import 'package:surf_network/surf_network.dart';

///Стандартный для проекта обработчик статус кода
class DefaultStatusMapper extends StandardStatusMapper {
  @override
  void checkClientStatus(Response response) {
    ErrorResponse er;

    //todo смаппить основные ошибки сервера в проекте
    try {
      er = ErrorResponse.fromJson(response.body);
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
