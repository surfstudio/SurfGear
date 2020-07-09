import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/const.dart';
import 'package:network/network.dart';

/// Реализация билдера заголовков http запросов
class DefaultHeaderBuilder extends HeadersBuilder {
  String t = emptyString;

  final AuthInfoStorage _ts;

  DefaultHeaderBuilder(this._ts);

  @override
  Future<Map<String, String>> buildDynamicHeader(String url) async {
    final token = await _ts.getAccessToken();
    return url != emptyString //todo доработать
        ? {
            'X-Auth-Token': token,
          }
        : {};
  }
}
