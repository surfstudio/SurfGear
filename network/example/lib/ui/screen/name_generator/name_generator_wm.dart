import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:rxdart/rxdart.dart';

/// WidgetModel для экрана счетчика
class NameGeneratorWidgetModel {
  List<User> _userList = [];

  final NameGeneratorInteractor _interactor;

  BehaviorSubject<bool> getUserAction = BehaviorSubject();
  BehaviorSubject<List<User>> listState = BehaviorSubject();

  NameGeneratorWidgetModel(
    this._interactor,
  ) {
    _listenToActions();
  }

  void _listenToActions() {
    listState.add([]);

    getUserAction.listen((_) {
      _interactor.getCard().listen((user) {
        _userList = listState.value;
        _userList.add(user);
        listState.add(_userList);
      });
    });
  }

  void dispose() {
    getUserAction.close();
    listState.close();
  }
}
