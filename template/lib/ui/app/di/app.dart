import 'package:flutter/material.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/auth/repository/auth_repository.dart';
import 'package:flutter_template/interactor/common/push/push_strategy_factory.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
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
import 'package:flutter_template/ui/res/assets.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';
import 'package:push/push.dart';

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
  DebugScreenInteractor debugScreenInteractor;

  MessagingService messagingService = MessagingService();
  NotificationController notificationController =
      NotificationController(androidMipMapIcon);
  PushHandler pushHandler;

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

    pushHandler = PushHandler(
      PushStrategyFactory(),
      notificationController,
      messagingService,
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

    debugScreenInteractor = DebugScreenInteractor(pushHandler);

    final messageController = MaterialMessageController(scaffoldKey);
    final wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        DefaultDialogController(scaffoldKey),
        scInteractor,
      ),
    );
    wm = AppWidgetModel(
      wmDependencies,
      messageController,
      navigatorKey,
      debugScreenInteractor,
    );
  }

  RxHttp _initHttp(AuthInfoStorage authStorage) {
    var proxyUrl = Environment<Config>.instance().config.proxyUrl;
    var dioHttp = DioHttp(
      config: HttpConfig(
        EMPTY_STRING,
        Duration(seconds: 30),
        proxyUrl: proxyUrl,
      ),
      errorMapper: DefaultStatusMapper(),
      headersBuilder: DefaultHeaderBuilder(authStorage),
    );
    return RxHttpDelegate(dioHttp);
  }
}
