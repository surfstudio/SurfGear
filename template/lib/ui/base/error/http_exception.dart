import 'package:dio/dio.dart';

///Основные http ошибки

///Базовое http исключение
abstract class HttpException implements Exception {
  HttpException(this.response);

  final Response response;
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
