import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/ui/base/headers.dart';
import 'package:flutter_template/util/const.dart';

/// Реализация билдера заголовков http запросов
class DefaultHeaderBuilder extends HeadersBuilder {
  DefaultHeaderBuilder(this._storage);

  final AuthInfoStorage _storage;

  @override
  Future<Map<String, String>> buildDynamicHeader(String url) async {
    final token = await _storage.getAccessToken();
    return url != emptyString //todo доработать
        ? {
            'X-Auth-Token': token,
          }
        : {};
  }
}
