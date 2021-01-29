import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template/ui/base/headers.dart';
import 'package:flutter_template/ui/base/standard_status_mapper.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:http_parser/http_parser.dart';

// ignore: prefer_mixin
class DefaultDio with DioMixin implements Dio {
  DefaultDio({
    this.errorMapper,
    this.headersBuilder,
    this.timeout,
    this.baseUrl,
    String proxyUrl,
    HttpClientAdapter adapter,
  }) {
    options = BaseOptions()
      ..baseUrl = baseUrl ?? emptyString
      ..connectTimeout = timeout?.inMilliseconds
      ..sendTimeout = timeout?.inMilliseconds
      ..receiveTimeout = timeout?.inMilliseconds;

    if (httpClientAdapter != null) {
      httpClientAdapter = adapter;
    }
    _configProxy(proxyUrl);
  }

  final StatusCodeMapper errorMapper;
  final HeadersBuilder headersBuilder;
  final Duration timeout;
  final String baseUrl;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    Map<String, String> headers,
    String contentType,
  }) async {
    final headersMap = await _buildHeaders(path, headers);
    return super
        .get<T>(
          path,
          queryParameters: queryParameters,
          options: options ??
              Options(
                headers: headersMap,
                contentType: contentType,
                sendTimeout: timeout.inMilliseconds,
                receiveTimeout: timeout.inMilliseconds,
              ),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    String contentType,
    Map<String, String> headers,
  }) async {
    final headersMap = await _buildHeaders(path, headers);
    return super
        .post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          onSendProgress: onSendProgress,
          options: options ??
              Options(
                headers: headersMap,
                contentType: contentType,
              ),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    String contentType,
    Map<String, String> headers,
  }) async {
    final headersMap = await _buildHeaders(path, headers);
    return super
        .put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          onSendProgress: onSendProgress,
          options: options ??
              Options(
                headers: headersMap,
                contentType: contentType,
              ),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    String contentType,
    Map<String, String> headers,
  }) async {
    final headersMap = await _buildHeaders(path, headers);
    return super
        .delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options ??
              Options(
                headers: headersMap,
                contentType: contentType,
              ),
          cancelToken: cancelToken,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    String contentType,
    Map<String, String> headers,
  }) async {
    final headersMap = await _buildHeaders(path, headers);
    return super
        .patch<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          onSendProgress: onSendProgress,
          options: options ??
              Options(
                headers: headersMap,
                contentType: contentType,
              ),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        )
        .then(_toResponse);
  }

  @override
  Future<Response<T>> head<T>(
    String path, {
    Object data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    String contentType,
    Map<String, String> headers,
  }) async {
    final headersMap = await _buildHeaders(path, headers);
    return super
        .head<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options ??
              Options(
                headers: headersMap,
                contentType: contentType,
              ),
          cancelToken: cancelToken,
        )
        .then(_toResponse);
  }

  Future<Response<T>> multipart<T>(
    String path, {
    Map<String, String> headers,
    File body,
    String contentType,
  }) async {
    final headersMap = await _buildHeaders(path, headers);

    final MultipartFile multipartFile = await MultipartFile.fromFile(
      body.path,
      contentType: MediaType('image', 'jpeg'),
    );
    final map = {'image': multipartFile};
    final data = FormData.fromMap(map);
    return post<T>(
      path,
      data: data,
      options: Options(
        headers: headersMap,
        contentType: contentType,
      ),
    ).then(_toResponse);
  }

  Future<Map<String, String>> _buildHeaders(
    String path,
    Map<String, String> headers,
  ) async {
    final headersMap = <String, String>{};
    if (headersBuilder != null) {
      headersMap.addAll(await headersBuilder.buildHeadersForUrl(path, headers));
    }
    logger.d('request  headers: $path, | $headersMap');
    return headersMap;
  }

  Response<T> _toResponse<T>(Response r) {
    final data = r.data as T;
    final response = Response<T>(data: data, statusCode: r.statusCode);
    errorMapper?.checkStatus(response);
    return response;
  }

  ///Proxy config for tracking data
  ///
  /// @param config - HttpConfig of client. Get proxy url
  void _configProxy(String proxyUrl) {
    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) => client.findProxy = (uri) => 'PROXY $proxyUrl';
    }
  }
}
