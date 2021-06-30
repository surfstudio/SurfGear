import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/repository/facts/facts_repository.dart';

/// Интерактор взаимодействия с фактами
class FactsInteractor {
  final FactsRepository _factsRepository;
  final _facts = <Fact>[];

  FactsInteractor(this._factsRepository);

  /// Получить список фактов
  Future<Iterable<Fact>> getFacts({int count = 1000}) async {
    final facts = await _factsRepository.getFacts(count);
    _facts
      ..clear()
      ..addAll(facts);
    return _facts;
  }

  /// Получить один факт
  Future<Iterable<Fact>> getFact() async {
    final fact = await _factsRepository.getFact();
    _facts.add(fact);
    return _facts;
  }
}
