import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';
import 'package:network/src/base/config.dart';
import 'package:network/src/base/headers.dart';
import 'package:network/src/base/http.dart';
import 'package:network/src/base/response.dart';
import 'package:network/src/base/status_mapper.dart';

///Реализация Http на основе библиотеки [dio]
class DioHttp extends Http {
  final HeadersBuilder headersBuilder;
  final StatusCodeMapper errorMapper;

  final _dio = dio.Dio();

  DioHttp({this.headersBuilder, HttpConfig config, this.errorMapper}) {
    _dio.options
      ..baseUrl = config.baseUrl
      ..connectTimeout = config.timeout.inMilliseconds
      ..receiveTimeout = config.timeout.inMilliseconds
      ..sendTimeout = config.timeout.inMilliseconds;

    _dio.interceptors.add(dio.LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    _dio.interceptors.add(dio.InterceptorsWrapper(onError: (e) {
      if (e.type == dio.DioErrorType.RESPONSE) {
        return e.response;
      }

      if (e is Error) {
        throw Exception((e as Error).stackTrace);
      }

      throw e;
    }));
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .get(
          url,
          queryParameters: query,
          options: dio.Options(headers: headersMap),
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> post<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .post(
          url,
          queryParameters: query,
          options: dio.Options(headers: headersMap),
          data: body,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> put<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .put(
          url,
          options: dio.Options(headers: headersMap),
          data: body,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .delete(
          url,
          queryParameters: query,
          options: dio.Options(headers: headersMap),
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> patch<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .patch(
          url,
          queryParameters: query,
          options: dio.Options(headers: headersMap),
          data: body,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> head<T>(
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  ) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .head(
          url,
          queryParameters: query,
          options: dio.Options(headers: headersMap),
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> multipart<T>(
    String url, {
    Map<String, String> headers,
    File body,
  }) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    final data = dio.FormData.from({
      "image": dio.UploadFileInfo(body, "image",
          contentType: ContentType("image", "jpeg")),
    });
    return _dio
        .post(
          url,
          data: data,
          options: dio.Options(headers: headersMap),
        )
        .then(_toResponse);
  }

  Future<Map<String, String>> _buildHeaders(
      String url, Map<String, String> headers) async {
    Map<String, String> headersMap = Map();
    if (headersBuilder != null) {
      headersMap.addAll(await headersBuilder.buildHeadersForUrl(url, headers));
    }

    Logger.d("request  headers: $url, | $headersMap");
    return headersMap;
  }

  Response<T> _toResponse<T>(dio.Response r) {
    var data = r.data;
    final response = Response<T>(data, r.statusCode);
    errorMapper.checkStatus(response);
    return response;
  }
}
