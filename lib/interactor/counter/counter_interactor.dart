import 'package:flutter_template/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  int _counter;

  final CounterRepository _counterRepository;

  CounterInteractor(this._counterRepository) {
    _counterRepository.getCounter().then((c) {
      _counter = c ?? 0;
      _subject.add(_counter);
    });

    _subject.listen(_counterRepository.setCounter);
  }

  BehaviorSubject<int> _subject = BehaviorSubject();

  Observable<int> get counterObservable => _subject.stream;

  incrementCounter() {
    _counter++;
    _subject.add(_counter);
  }
}
