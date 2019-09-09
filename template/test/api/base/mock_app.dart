/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/network/status_mapper.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/interactor/user/repository/user_repository.dart';
import 'package:flutter_template/interactor/user/user_interactor.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:network/network.dart';

/// Моковый компонент для тестирования сервисного слоя
class MockAppComponent {
  RxHttp http;

  UserInteractor userInteractor;
  AuthInfoStorage authStorage;
  PreferencesHelper preferencesHelper;

  MockAppComponent() {
    authStorage = AuthInfoStorage(preferencesHelper);
    preferencesHelper = PreferencesHelper();

    http = _initHttp(authStorage);

    userInteractor = UserInteractor(
      UserRepository(http),
    );
  }

  RxHttp _initHttp(AuthInfoStorage authStorage) {
    var dioHttp = DioHttp(
      config: HttpConfig(
        TEST_URL,
        Duration(seconds: 30),
      ),
      errorMapper: DefaultStatusMapper(),
    );
    return RxHttpDelegate(dioHttp);
  }
}
