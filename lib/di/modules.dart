import 'package:flutter_template/di/injector.dart';
import 'package:flutter_template/interactor/base/network.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:flutter_template/interactor/network/network.dart';
import 'package:flutter_template/util/sp_helper.dart';

class HttpModule extends Module<Http> {
  @override
  provides() {
    return Http(
      config: HttpConfig(
        Duration(seconds: 1),
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

class PreferencesModule extends Module<PreferencesHelper> {
  @override
  provides() {
    return PreferencesHelper.getInstance();
  }
}

class AppComponent extends Component {
  List<Module> _modules = List();

  AppComponent() {
    PreferencesModule _prefModule = PreferencesModule();
    _modules.add(_prefModule);
    _modules.add(HttpModule());
    _modules.add(CounterModule(_prefModule.provides()));
  }

  @override
  List<Module> getModules() {
    return _modules;
  }
}
