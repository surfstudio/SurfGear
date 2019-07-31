import 'package:counter/domain/counter.dart';
import 'package:counter/interactor/counter/repository/counter_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  Counter _counter;

  final CounterRepository _counterRepository;

  BehaviorSubject<Counter> _subject = BehaviorSubject();

  Observable<Counter> get counterObservable => _subject.stream;

  CounterInteractor(this._counterRepository) {
    Logger.d('call CounterInteractor constructor');
    _subject.listen(_counterRepository.setCounter);

    _counterRepository.getCounter().then((c) {
      _counter = c;
      _subject.add(_counter);
    });
  }

  void incrementCounter() {
    int c = _counter.count + 1;
    Logger.d(
        'call CounterInteractor.incrementCounter {counter=${_counter.count}}');
    _counter = Counter(c);
    _subject.add(_counter);
  }
}
