import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/network/status_mapper.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:network/network.dart';

/// Моковый компонент для тестирования сервисного слоя
class MockAppComponent {
  RxHttp http;

  AuthInfoStorage authStorage;
  PreferencesHelper preferencesHelper;

  MockAppComponent() {
    authStorage = AuthInfoStorage(preferencesHelper);
    preferencesHelper = PreferencesHelper();

    http = _initHttp(authStorage);
  }

  RxHttp _initHttp(AuthInfoStorage authStorage) {
    final dioHttp = DioHttp(
      config: HttpConfig(
        Url.testUrl,
        const Duration(seconds: 30),
      ),
      errorMapper: DefaultStatusMapper(),
    );
    return RxHttpDelegate(dioHttp);
  }
}
