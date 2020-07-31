// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:counter/domain/counter.dart';
import 'package:counter/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  CounterInteractor(this._counterRepository) {
    _subject.listen(_counterRepository.setCounter);

    _counterRepository.getCounter().then((c) {
      _counter = c;
      _subject.add(_counter);
    });
  }

  Counter _counter;

  final CounterRepository _counterRepository;

  final BehaviorSubject<Counter> _subject = BehaviorSubject();

  Stream<Counter> get counterObservable => _subject.stream;

  void incrementCounter() {
    final int c = _counter.count + 1;
    _counter = Counter(c);
    _subject.add(_counter);
  }
}
