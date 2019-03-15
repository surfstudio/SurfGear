import 'package:http/http.dart' as http;

///Wrapper over http 
/// todo
class Http {
  final HeadersBuilder headersBuilder;
  final HttpConfig config;

  Http({this.headersBuilder, this.config});

  Future<Response> get<T>(String url, {Map<String, String> headers}) {
    return http
        .get(url, headers: headersBuilder.headers)
        .timeout(config?.timeout)
        .then(_toResponse);
  }

  Future<Response> post<T>(String url,
      {Map<String, String> headers, body, encoding}) {
    return http
        .post(
          url,
          headers: _buildHeaders(headers),
          body: body,
          encoding: encoding,
        )
        .then(_toResponse);
  }

  Future<Response> put<T>(String url,
      {Map<String, String> headers, body, encoding}) {
    return http
        .put(
          url,
          headers: _buildHeaders(headers),
          body: body,
          encoding: encoding,
        )
        .then(_toResponse);
  }

  Future<Response> delete<T>(String url, {Map<String, String> headers}) {
    return http
        .delete(
          url,
          headers: _buildHeaders(headers),
        )
        .then(_toResponse);
  }

  Future<Response> patch<T>(String url,
      {Map<String, String> headers, body, encoding}) {
    return http
        .patch(
          url,
          headers: _buildHeaders(headers),
          body: body,
          encoding: encoding,
        )
        .then(_toResponse);
  }

  Future<Response> head<T>(String url, Map<String, String> headers) {
    return http
        .head(
          url,
          headers: _buildHeaders(headers),
        )
        .then(_toResponse);
  }

  Map<String, String> _buildHeaders(Map<String, String> headers) {
    Map<String, String> headersMap = Map.from(headersBuilder.headers);
    headersMap.addAll(headers);
    return headersMap;
  }

  Response _toResponse(http.Response r) =>
      Response(r.body, r.statusCode, r.contentLength, r.headers);
}

///Helper for headers
class HeadersBuilder {
  final Map<String, String> headers;

  HeadersBuilder(this.headers);
}

///Response
class Response {
  final dynamic body;
  final int statusCode;
  final int contentLength;
  final Map<String, String> headers;

  Response(this.body, this.statusCode, this.contentLength, this.headers);
}

class HttpConfig {
  final Duration timeout;

  HttpConfig(this.timeout);
}
