import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/user/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserInteractor {
  final BehaviorSubject<User> _userSubject = BehaviorSubject();
  final UserRepository userRepository;

  UserInteractor(this.userRepository);

  Observable<User> getUser() =>
      userRepository.getUser().doOnData((u) => _userSubject.add(u));
}
