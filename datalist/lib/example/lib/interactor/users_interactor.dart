import 'package:example/interactor/data/user.dart';
import 'package:example/interactor/users_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserInteractor {
  UsersRepository _repository;

  final BehaviorSubject<List<User>> _userSubject = BehaviorSubject();

  UserInteractor(this._repository);

  Observable<List<User>> getUserList() {
    return _repository.getUserList().doOnData((user) => _userSubject.add(user));
  }
}
