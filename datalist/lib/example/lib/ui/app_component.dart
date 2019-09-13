import 'package:example/interactor/users_interactor.dart';
import 'package:example/interactor/users_repository.dart';
import 'package:example/ui/app_wm.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

class AppComponent implements BaseWidgetModelComponent<AppWidgetModel> {
  UserInteractor _userInteractor;
  UsersRepository _usersRepository;

  AppComponent() {
    RxHttp _http = _initHttp();
    _usersRepository = UsersRepository(_http);
    _userInteractor = UserInteractor(_usersRepository);
  }

  RxHttp _initHttp() {
    var dioHttp = DioHttp(
      config: HttpConfig(
        "base_url",
        Duration(seconds: 30),
      ),
    );
    return RxHttpDelegate(dioHttp);
  }

  @override
  // TODO: implement wm
  AppWidgetModel get wm =>
      AppWidgetModel(WidgetModelDependencies(), _userInteractor);
}
