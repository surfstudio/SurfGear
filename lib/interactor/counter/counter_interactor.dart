import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  Counter _counter;

  final CounterRepository _counterRepository;

  CounterInteractor(this._counterRepository) {
    _counterRepository.getCounter().then((c) {
      _counter = c ?? 0;
      _subject.add(_counter);
    });

    _subject.listen(_counterRepository.setCounter);
  }

  BehaviorSubject<Counter> _subject = BehaviorSubject();

  Observable<Counter> get counterObservable => _subject.stream;

  incrementCounter() {
    int c = _counter.count + 1;
    _subject.add(Counter(c));
  }
}
