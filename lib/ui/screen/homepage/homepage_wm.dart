import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/user/user_interactor.dart';
import 'package:flutter_template/ui/base/action.dart';
import 'package:flutter_template/ui/base/entity_state.dart';
import 'package:flutter_template/ui/base/widget_model.dart';
import 'package:rxdart/subjects.dart';

///Модель виджета [MyHomePage]
class HomePageModel extends WidgetModel {
  final CounterInteractor _counterInteractor;
  final UserInteractor _userInteractor;

  BehaviorSubject<int> counterSubject = BehaviorSubject();
  BehaviorSubject<UserState> userStateSubject = BehaviorSubject();

  Action incrementAction = Action();

  HomePageModel(this._counterInteractor, this._userInteractor) {
    listenToStream(
      _counterInteractor.counterObservable,
      (c) => counterSubject.add(c.count),
    );

    listenToStream(counterSubject.stream, _loadRandomName);
    listenToStream(incrementAction.action, (v) => incrementCounter());
  }

  void incrementCounter() {
    _counterInteractor.incrementCounter();
  }

  _loadRandomName(int i) async {
    print("DEV_INFO loadName $i");
    if (i.isEven) {
      userStateSubject.add(UserState.loading());

      doFuture(
        _userInteractor.getUser(),
        (user) {
          print("DEV_INFO $user");
          userStateSubject.add(UserState.none(user));
        },
        onError: (e) {
          print("DEV_ERROR ${e.toString}");
          userStateSubject.add(UserState.error());
        },
      );
    }
  }
}

class UserState extends EntityState<User> {
  UserState.error() : super.error();

  UserState.loading() : super.loading();

  UserState.none(User user) : super.none(user);
}
