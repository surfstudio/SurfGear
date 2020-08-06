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

import 'package:flutter/material.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/interactor/common/push/push_strategy_factory.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/interactor/network/header_builder.dart';
import 'package:flutter_template/interactor/network/status_mapper.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:injector/injector.dart';
import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';
import 'package:push_notification/push_notification.dart';

/// Component per app
class AppComponent implements Component {
  AppComponent(BuildContext context) {
    context.toString();
    rebuildDependencies();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final navigator = GlobalKey<NavigatorState>();

  WidgetModelDependencies wmDependencies;
  MaterialMessageController messageController;
  DefaultDialogController dialogController;
  PreferencesHelper preferencesHelper = PreferencesHelper();
  AuthInfoStorage authStorage;
  RxHttp http;
  SessionChangedInteractor scInteractor;
  CounterInteractor counterInteractor;
  DebugScreenInteractor debugScreenInteractor;

  //MessagingService messagingService = MessagingService();
  NotificationController notificationController = NotificationController(() {
    Logger.d('permission declined');
  });
  PushHandler pushHandler;

  void rebuildDependencies() {
    _initDependencies();
  }

  void _initDependencies() {
    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    authStorage = AuthInfoStorage(preferencesHelper);
    http = _initHttp(authStorage);
    scInteractor = SessionChangedInteractor(authStorage);
    pushHandler = PushHandler(
        PushStrategyFactory(),
        notificationController,
        //messagingService,
        null);

    counterInteractor = CounterInteractor(
      CounterRepository(preferencesHelper),
    );

    debugScreenInteractor = DebugScreenInteractor(pushHandler);

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        DefaultDialogController(scaffoldKey),
        scInteractor,
      ),
    );
  }

  RxHttp _initHttp(AuthInfoStorage authStorage) {
    final proxyUrl = Environment<Config>.instance().config.proxyUrl;
    final dioHttp = DioHttp(
      config: HttpConfig(
        emptyString,
        const Duration(seconds: 30),
        proxyUrl: proxyUrl,
      ),
      errorMapper: DefaultStatusMapper(),
      headersBuilder: DefaultHeaderBuilder(authStorage),
    );
    return RxHttpDelegate(dioHttp);
  }
}
