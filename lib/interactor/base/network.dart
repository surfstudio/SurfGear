import 'package:http/http.dart' as http;

/// Wrapper over http
/// todo разобраться с обработкой ошибок
/// + сделать мапперы
/// + интерцепторы
/// + возмлжно переехать на дио
class Http {
  final HeadersBuilder headersBuilder;
  final HttpConfig config;
  final ErrorMapper errorMapper;

  Http({this.headersBuilder, this.config, this.errorMapper});

  ///GET- request
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
  Future<Response> post<T>(String url,
      {Map<String, String> headers, body, encoding}) async {
    print("DEV_WEB request : $url, $body | $headers");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .post(
          url,
          headers: headersMap,
          body: body,
          encoding: encoding,
        )
        .then(_toResponse);
//        .catchError(mapError);
  }

  ///PUT -request
  Future<Response> put<T>(String url,
      {Map<String, String> headers, body, encoding}) async {
    print("DEV_WEB request : $url, $body");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .put(
          url,
          headers: headersMap,
          body: body,
          encoding: encoding,
        )
        .then(_toResponse);
//        .catchError(mapError);
  }

  ///DELETE -request
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
  Future<Response> patch<T>(String url,
      {Map<String, String> headers, body, encoding}) async {
    print("DEV_WEB request : $url, $body");
    Map<String, String> headersMap = await _buildHeaders(url, headers);
    return http
        .patch(
          url,
          headers: headersMap,
          body: body,
          encoding: encoding,
        )
        .then(_toResponse);
//         .catchError(mapError);
  }

  ///HEAD - request
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
    if (r.statusCode == 400) {
      mapError(r.body);
    }
    return Response(r.body, r.statusCode, r.contentLength, r.headers);
  }

  dynamic mapError(Object e) {
    print("DEV_ERROR Http $e");
    errorMapper?.mapError(e);
  }
}

///Helper for headers
abstract class HeadersBuilder {
  static const String _DEFAULT_HEADERS_KEY = "";
  final Map<String, Map<String, String>> _headersInfo = {};
  final Map<String, List<String>> _exceptedUrls = {};

  Future<Map<String, String>> buildHeadersForUrl(
    String url,
    Map<String, String> headers,
  ) async {
    Map<String, String> headersMap = Map()..addAll(headers ?? {});
    _headersInfo[_DEFAULT_HEADERS_KEY].forEach(
      (key, value) {
        if (!(_exceptedUrls[key]?.contains(url) ?? false)) {
          headersMap[key] = value;
        }
      },
    );

    if (_headersInfo[url] == null) {
      print(
        "DEV_ERROR there are no specific headers for this url. Are you register it? \n $url",
      );
    }
    headersMap.addAll(_headersInfo[url] ?? {});
    headersMap.addAll(await buildDynamicHeader(url));

    print("""
      HEADERS: ${headersMap.entries.join(",")}
    """);
    return headersMap;
  }

  /// С помощью этого метода можно зарегистрировать заголовки по урл
  void registerHeaders(String url, Map<String, String> headers) {
    _headersInfo[url] = headers;
  }

  /// Регистрирует заголовки для всех без исключения урлов
  void registerDefault(Map<String, String> headers) {
    _headersInfo[_DEFAULT_HEADERS_KEY] = headers;
  }

  /// Регистрирует хедеры ко всем запросам кроме указанных
  void registerExcept(List<String> exceptedUrls, Map<String, String> headers) {
    headers.keys.forEach(
      (key) {
        _exceptedUrls[key] = exceptedUrls;
      },
    );
    _headersInfo[_DEFAULT_HEADERS_KEY].addAll(headers);
  }

  /// Метод для получения заголовков для динамических данных
  Future<Map<String, String>> buildDynamicHeader(String url) async => {};
}

///Helper for map errors
abstract class ErrorMapper {
  dynamic mapError(Object e);
}

///Response
class Response {
  final String body;
  final int statusCode;
  final int contentLength;
  final Map<String, String> headers;

  Response(this.body, this.statusCode, this.contentLength, this.headers);
}

///Http configuration
class HttpConfig {
  final Duration timeout;

  HttpConfig(this.timeout);
}
