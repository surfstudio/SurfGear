import 'package:counter/domain/counter.dart';
import 'package:counter/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  Counter _counter;

  final CounterRepository _counterRepository;

  BehaviorSubject<Counter> _subject = BehaviorSubject();

  Observable<Counter> get counterObservable => _subject.stream;

  CounterInteractor(this._counterRepository) {
    _subject.listen(_counterRepository.setCounter);

    _counterRepository.getCounter().then((c) {
      _counter = c;
      _subject.add(_counter);
    });
  }

  incrementCounter() {
    int c = _counter.count + 1;
    _counter = Counter(c);
    _subject.add(_counter);
  }
}
