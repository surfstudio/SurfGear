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

import 'package:network/src/base/response.dart';

///Основные http ошибки

///Базовое http исключение
abstract class HttpException implements Exception {
  final Response response;

  HttpException(this.response);
}

///Неизвестный статус код
class UnknownHttpStatusCode extends HttpException {
  UnknownHttpStatusCode(Response response) : super(response);
}

///Пришло не 2хх
class HttpProtocolException extends HttpException {
  HttpProtocolException(Response response) : super(response);
}

///Перенаправление 3xx
class RedirectionHttpException extends HttpProtocolException {
  RedirectionHttpException(Response response) : super(response);
}

///Ошибка клиента 4xx
class ClientHttpException extends HttpProtocolException {
  ClientHttpException(Response response) : super(response);
}

///Ошибка сервера 5xx
class ServerHttpException extends HttpException {
  ServerHttpException(Response response) : super(response);
}

///Интернет недоступен
class NoInternetException extends HttpException {
  NoInternetException(Response response) : super(response);
}

///Ошибка парсинга ответа
class ConversionException extends HttpException {
  ConversionException(Response response) : super(response);
}