import 'package:flutter_template/di/injector.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/screen/homepage/homepage.dart';

class HomePageModule extends Module<HomePageModel> {
  final CounterInteractor _counterInteractor;

  HomePageModule(this._counterInteractor);

  @override
  provides() {
    return HomePageModel(_counterInteractor);
  }
}

class HomePageComponent extends Component {
  final CounterInteractor _counterInteractor;

  HomePageComponent(this._counterInteractor);

  @override
  List<Module> getModules() {
    return [HomePageModule(_counterInteractor)];
  }
}
