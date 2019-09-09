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

import 'package:flutter/material.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/auth/repository/auth_repository.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:flutter_template/interactor/initial_progress/initial_progress_interactor.dart';
import 'package:flutter_template/interactor/initial_progress/storage/initial_progress_storage.dart';
import 'package:flutter_template/interactor/network/header_builder.dart';
import 'package:flutter_template/interactor/network/status_mapper.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/interactor/user/repository/user_repository.dart';
import 'package:flutter_template/interactor/user/user_interactor.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

/// Component per app
class AppComponent implements BaseWidgetModelComponent<AppWidgetModel> {
  AppWidgetModel wm;

  PreferencesHelper preferencesHelper = PreferencesHelper();
  AuthInfoStorage authStorage;
  RxHttp http;
  SessionChangedInteractor scInteractor;
  InitialProgressInteractor initInteractor;
  AuthInteractor authInteractor;
  CounterInteractor counterInteractor;
  UserInteractor userInteractor;

  AppComponent(
    GlobalKey<NavigatorState> navigatorKey,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    authStorage = AuthInfoStorage(preferencesHelper);
    http = _initHttp(authStorage);
    scInteractor = SessionChangedInteractor(authStorage);
    initInteractor = InitialProgressInteractor(
      InitialProgressStorage(preferencesHelper),
    );
    authInteractor = AuthInteractor(
      AuthRepository(http, authStorage),
      scInteractor,
    );
    counterInteractor = CounterInteractor(
      CounterRepository(preferencesHelper),
    );
    userInteractor = UserInteractor(
      UserRepository(http),
    );

    final messageController = MaterialMessageController(scaffoldKey);
    final wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        DefaultDialogController(scaffoldKey),
        scInteractor,
      ),
    );
    wm = AppWidgetModel(wmDependencies, messageController, navigatorKey);
  }

  RxHttp _initHttp(AuthInfoStorage authStorage) {
    var dioHttp = DioHttp(
      config: HttpConfig(
        BASE_URL,
        Duration(seconds: 30),
      ),
      errorMapper: DefaultStatusMapper(),
      headersBuilder: DefaultHeaderBuilder(authStorage),
    );
    return RxHttpDelegate(dioHttp);
  }
}
