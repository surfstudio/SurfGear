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

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:network/src/base/config/config.dart';
import 'package:network/src/base/headers.dart';
import 'package:network/src/base/http.dart';
import 'package:network/src/base/response.dart';
import 'package:network/src/base/status_mapper.dart';
import 'package:network/src/impl/dio/interceptor/dio_interceptor.dart';

///Library Based Http Implementation [dio]
class DioHttp extends Http {
  final HeadersBuilder headersBuilder;
  final StatusCodeMapper errorMapper;

  final _dio = dio.Dio();

  DioHttp({
    this.headersBuilder,
    HttpConfig config,
    this.errorMapper,
    List<DioInterceptor> interceptors,
    dio.HttpClientAdapter httpClientAdapter,
  }) {
    _dio.options
      ..baseUrl = config.baseUrl
      ..connectTimeout = config.timeout.inMilliseconds
      ..receiveTimeout = config.timeout.inMilliseconds
      ..sendTimeout = config.timeout.inMilliseconds;

    if (httpClientAdapter != null) _dio.httpClientAdapter = httpClientAdapter;

    _configProxy(config);
    interceptors
        ?.map((interceptor) => DioInterceptorDecorator(interceptor))
        ?.forEach((interceptor) => _dio.interceptors.add(interceptor));

    var logConfig = config.logConfig;
    if (logConfig != null) {
      _dio.interceptors.add(dio.LogInterceptor(
        request: logConfig.options,
        requestHeader: logConfig.requestHeader,
        requestBody: logConfig.requestBody,
        responseHeader: logConfig.requestHeader,
        responseBody: logConfig.responseBody,
        error: logConfig.error,
      ));
    }

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

  ///Proxy config for tracking data
  ///
  /// @param config - HttpConfig of client. Get proxy url
  void _configProxy(HttpConfig config) {
    var proxyUrl = config.proxyUrl;

    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $proxyUrl";
        };
      };
    }
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
    final data = dio.FormData.fromMap({
      "image": dio.MultipartFile.fromFile(
        body.path,
        contentType: MediaType("image", "jpeg"),
      ),
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
