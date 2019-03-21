import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/user/repository/name_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserInteractor {
  final BehaviorSubject<User> _userSubject = BehaviorSubject();
  final UserRepository userRepository;

  UserInteractor(this.userRepository);

  Future<User> getUser() {
    return userRepository.getUser().then((u) {
      _userSubject.add(u);
      return u;
    });
  }
}
