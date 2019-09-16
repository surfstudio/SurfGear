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

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as json;
import 'package:network/src/base/config.dart';
import 'package:network/src/base/status_mapper.dart';
import 'package:network/src/base/headers.dart';
import 'package:network/src/base/http.dart';
import 'package:network/src/base/response.dart';
import 'package:logger/logger.dart';

/// Реализация Http на основе стандартного [http]
/// Response.bodyRaw всегда String.
/// 
/// todo по необходимости реализовать логику query - в текущей реализации не работает
class DefaultHttp extends Http {
  final HeadersBuilder headersBuilder;
  final HttpConfig config;
  final StatusCodeMapper errorMapper;

  DefaultHttp({this.headersBuilder, this.config, this.errorMapper});

  ///GET- request
  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .get(
          url,
          headers: headersMap,
        )
        .timeout(config?.timeout)
        .then(_toResponse);
  }

  ///POST-request
  @override
  Future<Response<T>> post<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    print("DEV_WEB request : $url, $body | $headers");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .post(
          url,
          headers: headersMap,
          body: json.jsonEncode(body),
        )
        .then(_toResponse);
  }

  ///PUT -request
  @override
  Future<Response<T>> put<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    print("DEV_WEB request : $url, $body");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .put(
          url,
          headers: headersMap,
          body: json.jsonEncode(body),
        )
        .then(_toResponse);
  }

  ///DELETE -request
  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .delete(
          url,
          headers: headersMap,
        )
        .then(_toResponse);
  }

  ///PATCH -request
  @override
  Future<Response<T>> patch<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    print("DEV_WEB request : $url, $body");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .patch(
          url,
          headers: headersMap,
          body: json.jsonEncode(body),
        )
        .then(_toResponse);
  }

  ///HEAD - request
  @override
  Future<Response<T>> head<T>(
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  ) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .head(
          url,
          headers: headersMap,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> multipart<T>(
    String url, {
    Map<String, String> headers,
    File body,
  }) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);

    final request = http.MultipartRequest("POST", Uri.parse(url));
    final bytes = await body.readAsBytes();
    final file = http.MultipartFile.fromBytes(
      "image",
      bytes,
      contentType: MediaType("image", "jpeg"),
    );

    request.files.add(file);
    headersMap.entries
        .forEach((entry) => request.headers[entry.key] = entry.value);

    return request.send().then(http.Response.fromStream).then(_toResponse);
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

  Response<T> _toResponse<T>(http.Response r) {
    Logger.d("${r.statusCode} | ${r.body}");
    final response = Response<T>(r.body as dynamic, r.statusCode);
    if (response.statusCode == 400) {
      mapError(response);
    }
    return response;
  }

  dynamic mapError(Response e) {
    errorMapper?.checkStatus(e);
  }
}
