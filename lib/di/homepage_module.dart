import 'package:flutter_template/di/base/component.dart';
import 'package:flutter_template/di/base/module.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/random_name/user_interactor.dart';
import 'package:flutter_template/ui/screen/homepage/homepage.dart';

/// Component for dependencies for HomePage
class HomePageComponent extends Component {
  final CounterInteractor _counterInteractor;
  final UserInteractor _userInteractor;

  HomePageComponent(this._counterInteractor, this._userInteractor);

  @override
  List<Module> getModules() {
    return [HomePageModule(_counterInteractor, _userInteractor)];
  }
}

/// модуль, создающий модель главной страницы
/// а так же пробрасывающий в нее зависимости
class HomePageModule extends Module<HomePageModel> {
  final CounterInteractor _counterInteractor;
  final UserInteractor _userInteractor;

  HomePageModule(this._counterInteractor, this._userInteractor);

  @override
  provides() {
    return HomePageModel(_counterInteractor, _userInteractor);
  }
}
