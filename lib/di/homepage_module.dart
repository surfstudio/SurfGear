import 'package:flutter_template/di/base/component.dart';
import 'package:flutter_template/di/base/module.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/screen/homepage/homepage.dart';

/// Component for dependencies for HomePage
class HomePageComponent extends Component {
  final CounterInteractor _counterInteractor;

  HomePageComponent(this._counterInteractor);

  @override
  List<Module> getModules() {
    return [HomePageModule(_counterInteractor)];
  }
}

/// модуль, создающий модель главной страницы
/// а так же пробрасывающий в нее зависимости
class HomePageModule extends Module<HomePageModel> {
  final CounterInteractor _counterInteractor;

  HomePageModule(this._counterInteractor);

  @override
  provides() {
    return HomePageModel(_counterInteractor);
  }
}
