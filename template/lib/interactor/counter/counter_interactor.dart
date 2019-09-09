/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

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
