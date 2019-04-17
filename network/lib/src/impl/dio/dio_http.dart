import 'package:network/src/config.dart';
import 'package:network/src/errors/error_mapper.dart';
import 'package:network/src/headers.dart';
import 'package:network/src/http.dart';
import 'package:network/src/response.dart';
import 'package:dio/dio.dart' as dio;

class DioHttp extends Http {
  final HeadersBuilder headersBuilder;
  final StatusCodeMapper errorMapper;

  final _dio = dio.Dio();

  DioHttp({this.headersBuilder, HttpConfig config, this.errorMapper}) {
    _dio.options.baseUrl = config.baseUrl;
    _dio.options.connectTimeout = config.timeout.inMilliseconds;
    _dio.options.receiveTimeout = config.timeout.inMilliseconds;
    _dio.options.sendTimeout = config.timeout.inMilliseconds;
  }

  @override
  Future<Response> get<T>(String url, {Map<String, String> headers}) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .get(
          url,
          options: dio.Options(headers: headersMap),
        )
        .then(_toResponse);
  }

  @override
  Future<Response> post<T>(String url,
      {Map<String, String> headers, Map<String, dynamic> body}) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .post(
          url,
          options: dio.Options(headers: headersMap),
          data: body,
        )
        .then(_toResponse);
  }

  @override
  Future<Response> put<T>(String url,
      {Map<String, String> headers, body}) async {
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
  Future<Response> delete<T>(String url, {Map<String, String> headers}) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .delete(
          url,
          options: dio.Options(headers: headersMap),
        )
        .then(_toResponse);
  }

  @override
  Future<Response> patch<T>(String url,
      {Map<String, String> headers, body}) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .patch(
          url,
          options: dio.Options(headers: headersMap),
          data: body,
        )
        .then(_toResponse);
  }

  @override
  Future<Response> head<T>(String url, Map<String, String> headers) async {
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return _dio
        .head(
          url,
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

    print("DEV_WEB request  headers: $url, | $headersMap");
    return headersMap;
  }

  Response _toResponse(dio.Response r) {
    final response = Response(r.data, r.statusCode);
    errorMapper.checkStatus(response);
    return response;
  }
}
