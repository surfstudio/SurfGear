import 'package:flutter_template/di/base/component.dart';
import 'package:flutter_template/di/base/module.dart';
import 'package:flutter_template/interactor/base/network.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:flutter_template/interactor/network/network.dart';
import 'package:flutter_template/interactor/random_name/repository/name_repository.dart';
import 'package:flutter_template/interactor/random_name/user_interactor.dart';
import 'package:flutter_template/util/sp_helper.dart';

/// Component per app
class AppComponent extends Component {
  List<Module> _modules = List();

  AppComponent() {
    PreferencesModule _prefModule = PreferencesModule();
    HttpModule _httpModule = HttpModule();
    _modules.add(_prefModule);
    _modules.add(_httpModule);
    _modules.add(CounterModule(_prefModule.provides()));
    _modules.add(UserModule(_httpModule.provides()));
  }

  @override
  List<Module> getModules() {
    return _modules;
  }
}

//region Modules for app component
class HttpModule extends Module<Http> {
  @override
  provides() {
    return Http(
      config: HttpConfig(
        Duration(seconds: 30),
      ),
      errorMapper: CustomErrorMapper(),
    );
  }
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
