import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:injector/injector.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:flutter_template/interactor/initial_progress/initial_progress_interactor.dart';
import 'package:flutter_template/interactor/network/status_mapper.dart';
import 'package:flutter_template/interactor/network/header_builder.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/interactor/user/repository/name_repository.dart';
import 'package:flutter_template/interactor/user/user_interactor.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/app/di/auth_module.dart';
import 'package:flutter_template/ui/app/di/initial_progress_module.dart';
import 'package:flutter_template/ui/app/di/push_module.dart';
import 'package:flutter_template/ui/app/di/session_changed_module.dart';
import 'package:flutter_template/ui/app/di/token_storage_module.dart';
import 'package:mwwm/mwwm.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:flutter_template/ui/base/standard_error_handler.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:network/network.dart';

/// Component per app
class AppComponent extends Component {
  List<Module> _modules = List();

  AppComponent(
    GlobalKey<NavigatorState> navigatorKey,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    PreferencesModule _prefModule = PreferencesModule();
    PushModule _pushModule = PushModule();
    final _notificationControllerModule = NotificationControllerModule();
    TokenStorageModule ts = TokenStorageModule(_prefModule.provides());
    HttpModule _httpModule = HttpModule(ts.provides());
    SessionChangedModule scModule = SessionChangedModule(ts.provides());
    InitialProgressInteractorModule initialProgressInteractorModule =
        InitialProgressInteractorModule(
      _prefModule.provides(),
    );
    AuthModule authModule = AuthModule(
      _httpModule.provides(),
      _pushModule.provides(),
      _prefModule.provides(),
      ts.provides(),
      scModule.provides(),
    );
    _modules.add(_prefModule);
    _modules.add(_httpModule);
    _modules.add(_pushModule);
    _modules.add(_notificationControllerModule);
    _modules.add(authModule);
    _modules.add(initialProgressInteractorModule);
    _modules.add(AppWidgetModule(
      authModule.provides(),
      navigatorKey,
      scaffoldKey,
      initialProgressInteractorModule.provides(),
    ));
    _modules.add(CounterModule(_prefModule.provides()));
    _modules.add(UserModule(_httpModule.provides()));
  }

  @override
  List<Module> getModules() {
    return _modules;
  }
}

class AppWidgetModule extends Module<AppWidgetModel> {
  AppWidgetModel _model;

  AppWidgetModule(
    AuthInteractor authInteractor,
    GlobalKey<NavigatorState> navigatorKey,
    GlobalKey<ScaffoldState> scaffoldState,
    InitialProgressInteractor initialProgressInteractor,
  ) {
    _model = AppWidgetModel(
      WidgetModelDependencies(
        errorHandler: StandardErrorHandler(
          MaterialMessageController(scaffoldState),
          navigatorKey.currentState,
        ),
        navigator: navigatorKey.currentState,
      ),
      null,
      navigatorKey,
    );
  }

  @override
  provides() {
    return _model;
  }
}

//region Modules for app component
class HttpModule extends Module<Http> {
  Http _http;

  HttpModule(AuthInfoStorage ts) {
    _http = DioHttp(
      config: HttpConfig(
        BASE_URL,
        Duration(seconds: 30),
      ),
      errorMapper: DefaultStatusMapper(),
      headersBuilder: DefaultHeaderBuilder(ts),
    );
  }

  @override
  provides() => _http;
}

class CounterModule extends Module {
  final PreferencesHelper _helper;
  CounterInteractor _interactor;

  CounterModule(this._helper) {
    _interactor = CounterInteractor(CounterRepository(_helper));
  }

  @override
  provides() {
    return _interactor;
  }
}

class UserModule extends Module<UserInteractor> {
  UserInteractor _interactor;
  Http _http;

  UserModule(this._http) {
    _interactor = UserInteractor(UserRepository(_http));
  }

  @override
  provides() {
    return _interactor;
  }
}

class PreferencesModule extends Module<PreferencesHelper> {
  @override
  provides() {
    return PreferencesHelper();
  }
}

//endregion
