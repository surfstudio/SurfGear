import 'dart:io';

import 'package:network/src/base/response.dart';

///Фасад над работой с сетью
abstract class Http {
  ///GET- request
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  ///POST-request
  Future<Response<T>> post<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  ///PUT -request
  Future<Response<T>> put<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  ///DELETE -request
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  ///PATCH -request
  Future<Response<T>> patch<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  ///HEAD - request
  Future<Response<T>> head<T>(
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  );

  /// Multipart request
  Future<Response<T>> multipart<T>(
    String url, {
    Map<String, String> headers,
    File body,
  });
}
