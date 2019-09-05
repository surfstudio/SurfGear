import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/repository/name_generator_repository.dart';
import 'package:rxdart/rxdart.dart';

class NameGeneratorInteractor {
  final NameGeneratorRepository _repository;

  NameGeneratorInteractor(this._repository);

  /// Получение параметров пользователя
  Observable<User> getCard() => _repository.getUser();
}
