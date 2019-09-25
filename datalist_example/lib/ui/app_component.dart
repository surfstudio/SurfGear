import 'package:datalist_example/interactor/user_interactor.dart';
import 'package:datalist_example/interactor/user_repository.dart';
import 'package:datalist_example/ui/app_wm.dart';
import 'package:mwwm/mwwm.dart';
import 'package:http/http.dart' as http;

class AppComponent implements BaseWidgetModelComponent<AppWidgetModel> {
  UserInteractor _userInteractor;
  UserRepository _usersRepository;

  AppComponent() {
    _usersRepository = UserRepository(http.Client());
    _userInteractor = UserInteractor(_usersRepository);
  }

  @override
  AppWidgetModel get wm => AppWidgetModel(
      WidgetModelDependencies(errorHandler: CustomErrorHandler()),
      _userInteractor);
}

class CustomErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {}
}
