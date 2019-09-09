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

///Helper for headers
abstract class HeadersBuilder {
  static const String _DEFAULT_HEADERS_KEY = "";
  final Map<String, Map<String, String>> _headersInfo = {};
  final Map<String, List<String>> _exceptedUrls = {};

  /// Метод для получения заголовков для динамических данных
  Future<Map<String, String>> buildDynamicHeader(String url) async => {};

  Future<Map<String, String>> buildHeadersForUrl(
    String url,
    Map<String, String> headers,
  ) async {
    Map<String, String> headersMap = Map()..addAll(headers ?? {});
    final defaultHeaders = _headersInfo[_DEFAULT_HEADERS_KEY];
    if (defaultHeaders != null) {
      defaultHeaders.forEach(
        (key, value) {
          if (!(_exceptedUrls[key]?.contains(url) ?? false)) {
            headersMap[key] = value;
          }
        },
      );
    }

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
}
