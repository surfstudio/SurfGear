import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/const.dart';
import 'package:surf_network/surf_network.dart';

/// Реализация билдера заголовков http запросов
class DefaultHeaderBuilder extends HeadersBuilder {
  DefaultHeaderBuilder(this._ts);

  String t = emptyString;

  final AuthInfoStorage _ts;

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
