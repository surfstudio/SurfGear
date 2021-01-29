import 'package:dio/dio.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/network/status_mapper.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/ui/base/default_dio.dart';
import 'package:flutter_template/util/sp_helper.dart';

/// Моковый компонент для тестирования сервисного слоя
class MockAppComponent {
  MockAppComponent() {
    authStorage = AuthInfoStorage(preferencesHelper);
    preferencesHelper = PreferencesHelper();

    dio = _initDio(authStorage);
  }

  AuthInfoStorage authStorage;
  PreferencesHelper preferencesHelper;

  Dio dio;

  Dio _initDio(AuthInfoStorage authStorage) {
    final dio = DefaultDio(
      timeout: const Duration(seconds: 30),
      errorMapper: DefaultStatusMapper(),
      baseUrl: Url.testUrl,
    );
    return dio;
  }
}
