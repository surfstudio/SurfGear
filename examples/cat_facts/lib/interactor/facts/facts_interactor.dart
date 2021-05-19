import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/repository/facts_repository.dart';

/// Интерактор взаимодействия с фактами
class FactsInteractor {
  final FactsRepository _factsRepository;

  FactsInteractor(this._factsRepository);

  /// Получить список фактов
  Future<Iterable<Fact>> getFacts() {
    return _factsRepository.getFacts();
  }
}
