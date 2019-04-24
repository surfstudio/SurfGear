import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/auth/repository/auth_repository.dart';
import 'package:flutter_template/interactor/common/push/notification/notification_controller.dart';
import 'package:flutter_template/interactor/common/push/push_manager.dart';
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
  PushManager pushManager = PushManager();
  NotificationController notificationController = NotificationController();
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
      pushManager,
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
      ),
      navigator: navigatorKey.currentState,
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
