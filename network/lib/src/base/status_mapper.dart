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

import 'package:network/src/base/error/http_exceptions.dart';
import 'package:network/src/base/response.dart';

///Хелпер для проверки статус кода
abstract class StatusCodeMapper {
  checkStatus(Response response);
}

///Стандартный обработчик статус кода
class StandardStatusMapper extends StatusCodeMapper {
  @override
  checkStatus(Response response) {
    final statusCategory = _getFirstNumberFromStatus(response.statusCode);
    switch (statusCategory) {
      case 1:
        checkInformationalStatus(response);
        return;
      case 2:
        checkSuccessStatus(response);
        return;
      case 3:
        checkRedirectStatus(response);
        return;
      case 4:
        checkClientStatus(response);
        return;
      case 5:
        checkServerStatus(response);
        return;
      default:
        throw UnknownHttpStatusCode(response);
    }
  }

  ///status 1xx
  void checkInformationalStatus(Response response) {}

  ///status 2xx
  void checkSuccessStatus(Response response) {}

  ///status 3xx
  void checkRedirectStatus(Response response) {
    throw RedirectionHttpException(response);
  }

  ///status 4xx
  void checkClientStatus(Response response) {
    throw ClientHttpException(response);
  }

  ///status 5xx
  void checkServerStatus(Response response) {
    throw ServerHttpException(response);
  }

  ///получить первую цифру статус кода
  int _getFirstNumberFromStatus(int status) {
    final firstNumberStr = status.toString()[0];
    return int.parse(firstNumberStr);
  }
}
