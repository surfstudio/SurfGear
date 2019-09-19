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

import 'package:mwwm/src/entity_state.dart';
import 'package:mwwm/src/event/event.dart';
import 'package:rxdart/rxdart.dart';

///Состояние некого типа, обёрнутое в поток
///Характерно для связи WidgetModel -> Widget
class StreamedState<T> implements Event<T> {
  BehaviorSubject<T> _stateSubject = BehaviorSubject();

  T get value => _stateSubject.value;

  @override
  Observable<T> get stream => _stateSubject.stream;

  StreamedState([T initialData]) {
    if (initialData != null) accept(initialData);
  }

  @override
  Future<void> accept([T data]) {
    _stateSubject.add(data);
    return _stateSubject.stream.first.wrapped;
  }

  dispose() {
    _stateSubject.close();
  }
}

///Связь WidgetModel -> Widget, имеющая состояние загрузки/ошибки/контента
class EntityStreamedState<T> extends StreamedState<EntityState<T>>
    implements EntityEvent<T> {
  EntityStreamedState([EntityState<T> initialData]) : super(initialData);

  @override
  Future<void> content([T data]) {
    final newState = EntityState<T>.content(data);
    return super.accept(newState);
  }

  @override
  Future<void> error([Exception error]) {
    final newState = EntityState<T>.error(error);
    return super.accept(newState);
  }

  @override
  Future<void> loading() {
    final newState = EntityState<T>.loading();
    return super.accept(newState);
  }
}
