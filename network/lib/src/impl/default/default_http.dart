import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:network/src/config.dart';
import 'package:network/src/errors/error_mapper.dart';
import 'package:network/src/headers.dart';
import 'package:network/src/http.dart';
import 'package:network/src/response.dart';

class DefaultHttp extends Http {
  final HeadersBuilder headersBuilder;
  final HttpConfig config;
  final StatusCodeMapper errorMapper;

  DefaultHttp({this.headersBuilder, this.config, this.errorMapper});

  ///GET- request
  @override
  Future<Response> get<T>(String url, {Map<String, String> headers}) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .get(
          url,
          headers: headersMap,
        )
        .timeout(config?.timeout)
        .then(_toResponse);
//        .catchError(mapError);
  }

  ///POST-request
  @override
  Future<Response> post<T>(String url,
      {Map<String, String> headers, Map<String, dynamic> body}) async {
    print("DEV_WEB request : $url, $body | $headers");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .post(
          url,
          headers: headersMap,
          body: json.jsonEncode(body),
        )
        .then(_toResponse);
//        .catchError(mapError);
  }

  ///PUT -request
  @override
  Future<Response> put<T>(String url,
      {Map<String, String> headers, Map<String, dynamic> body}) async {
    print("DEV_WEB request : $url, $body");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .put(
          url,
          headers: headersMap,
          body: json.jsonEncode(body),
        )
        .then(_toResponse);
//        .catchError(mapError);
  }

  ///DELETE -request
  @override
  Future<Response> delete<T>(String url, {Map<String, String> headers}) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .delete(
          url,
          headers: headersMap,
        )
        .then(_toResponse);
//        .catchError(mapError);
  }

  ///PATCH -request
  @override
  Future<Response> patch<T>(String url,
      {Map<String, String> headers, Map<String, dynamic> body}) async {
    print("DEV_WEB request : $url, $body");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .patch(
          url,
          headers: headersMap,
          body: json.jsonEncode(body),
        )
        .then(_toResponse);
//         .catchError(mapError);
  }

  ///HEAD - request
  @override
  Future<Response> head<T>(String url, Map<String, String> headers) async {
    print("DEV_WEB request : $url");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .head(
          url,
          headers: headersMap,
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

  Response _toResponse(http.Response r) {
    print("DEV_WEB ${r.statusCode} | ${r.body}");
    final response = Response(json.jsonDecode(r.body), r.statusCode);
    if (response.statusCode == 400) {
      mapError(response);
    }
    return response;
  }

  dynamic mapError(Response e) {
    print("DEV_ERROR Http $e");
    errorMapper?.checkStatus(e);
  }
}
