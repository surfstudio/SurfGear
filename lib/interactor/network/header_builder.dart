import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/const.dart';
import 'package:network/network.dart';

/// Реализация билдера заголовков http запросов
class DefaultHeaderBuilder extends HeadersBuilder {
  String t = EMPTY_STRING;

  String get _token => t;
  final AuthInfoStorage _ts;

  DefaultHeaderBuilder(this._ts) {
    //обязательная авторизация в 1с (вытащил заголовок из браузера)
    //учетка: shilov/89HHn4xx - она будет практически постоянной
    //от нее видимо берется некий хеш
    registerDefault({"Authorization": "Basic c2hpbG92Ojg5SEhuNHh4"});
  }

  @override
  Future<Map<String, String>> buildDynamicHeader(String url) async {
    var token = await _ts.getAccessToken();
    return url != EMPTY_STRING //todo доработать
        ? {
            "X-Auth-Token": token,
          }
        : {};
  }
}
