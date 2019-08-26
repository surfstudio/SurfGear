///Helper for url params (header or query)
abstract class UrlParamsBuilder {
  static const String _DEFAULT_KEY = "|";
  final Map<String, Map<String, dynamic>> _registeredInfo = {};
  final Map<String, List<String>> _exceptedUrls = {};

  /// Метод для получения параметров для динамических данных
  Future<Map<String, dynamic>> buildDynamic(String url) async => {};

  Future<Map<String, dynamic>> buildForUrl(
    String url,
    Map<String, dynamic> params,
  ) async {
    Map<String, dynamic> paramsMap = Map()..addAll(params ?? {});
    final defaultMap = _registeredInfo[_DEFAULT_KEY];
    if (defaultMap != null) {
      defaultMap.forEach(
        (key, value) {
          _exceptedUrls[key]?.forEach((excepted) {
            if (!(url.contains(excepted?? " ") ?? false)) {
              paramsMap[key] = value;
            }
          });

          if (_exceptedUrls.isEmpty) paramsMap[key] = value;
        },
      );
    }

    var urlKey = _registeredInfo.keys
        .firstWhere((key) => url.contains(key), orElse: () => null);
    if (urlKey != null) {
      paramsMap.addAll(_registeredInfo[urlKey]);
    }
    paramsMap.addAll(await buildDynamic(url));

    return paramsMap;
  }

  /// С помощью этого метода можно зарегистрировать значения по урл
  /// * может быть лишь часть url
  void registerUrl(String url, Map<String, dynamic> params) {
    _registeredInfo[url] = params;
  }

  /// Регистрирует значения для всех без исключения урлов
  void registerDefault(Map<String, dynamic> params) {
    _registeredInfo[_DEFAULT_KEY] = params;
  }

  /// Регистрирует значения ко всем запросам кроме указанных
  void registerExcept(List<String> exceptedUrls, Map<String, dynamic> params) {
    params.keys.forEach(
      (key) {
        _exceptedUrls[key] = exceptedUrls;
      },
    );
    _registeredInfo[_DEFAULT_KEY] = params;
  }
}
