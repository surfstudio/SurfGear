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

import 'package:relation/src/relation/relation_event.dart';
import 'package:relation/src/relation/state/streamed_state.dart';

///[StreamedState] that have download/error/content status
class EntityStreamedState<T> extends StreamedState<EntityState<T>>
    implements EntityEvent<T, EntityState<T>> {
  EntityStreamedState([EntityState<T>? initialData]) : super(initialData);

  EntityStreamedState.from(Stream<EntityState<T>> stream) : super.from(stream);

  @override
  Future<EntityState<T>?> content([T? data]) {
    final newState = EntityState<T>.content(data);
    return super.accept(newState);
  }

  @override
  Future<EntityState<T>?> error([Object? error, T? data]) {
    final newState = EntityState<T>.error(error, data);
    return super.accept(newState);
  }

  @override
  Future<EntityState<T>?> loading([T? previousData]) {
    final newState = EntityState<T>.loading(previousData);
    return super.accept(newState);
  }
}

/// State of some logical entity
class EntityState<T> {
  /// Data of entity
  final T? data;

  /// State is loading
  final bool isLoading;

  /// State has error
  final bool hasError;

  /// Error from state
  final Object? error;

  const EntityState({
    this.data,
    this.isLoading = false,
    this.hasError = false,
    this.error,
  });

  /// Loading constructor
  EntityState.loading([this.data])
      : isLoading = true,
        hasError = false,
        error = null;

  /// Error constructor
  EntityState.error([this.error, this.data])
      : isLoading = false,
        hasError = true;

  /// Content constructor
  EntityState.content([this.data])
      : isLoading = false,
        hasError = false,
        error = null;
}
