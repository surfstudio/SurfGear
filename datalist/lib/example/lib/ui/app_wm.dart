import 'package:example/interactor/users_interactor.dart';
import 'package:mwwm/mwwm.dart';

class AppWidgetModel extends WidgetModel {
  

  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
    UserInteractor usersInteractor,
  ) : super(baseDependencies);
}
