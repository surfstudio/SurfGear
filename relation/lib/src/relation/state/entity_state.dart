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

import 'package:relation/src/relation/event.dart';
import 'package:relation/src/relation/state/streamed_state.dart';

import 'package:mwwm/mwwm.dart';

///[StreamedState] that have download/error/content status
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

///Стейт некоторой логической сущности
class EntityState<T> {
  final T data;
  final bool isLoading;
  final bool hasError;
  ExceptionWrapper error;

  //возможные поля
  // final List<Exception> errors

  EntityState({
    this.data,
    this.isLoading = false,
    this.hasError = false,
    dynamic error,
  }): error = ExceptionWrapper(error);

  EntityState.loading([T previousData])
      : isLoading = true,
        hasError = false,
        data = previousData;

  EntityState.error([dynamic error, T previousData])
      : isLoading = false,
        hasError = true,
        error = ExceptionWrapper(error),
        data = previousData;

  EntityState.content([T data])
      : isLoading = false,
        hasError = false,
        data = data;
}