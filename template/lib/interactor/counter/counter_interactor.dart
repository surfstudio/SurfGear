import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  Counter _counter;

  final CounterRepository _counterRepository;

  PublishSubject<Counter> _subject = PublishSubject();

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
