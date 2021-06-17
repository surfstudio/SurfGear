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

///[StreamedState] that have download/error/content status
class EntityStreamedState<T> extends StreamedState<EntityState<T>>
    implements EntityEvent<T, EntityState<T>> {
  EntityStreamedState([EntityState<T>? initialData])
      : super(initialData ?? EntityState<T>());

  @Deprecated('Better use other subjects or streams')
  // ignore: deprecated_member_use_from_same_package
  EntityStreamedState.from(Stream<EntityState<T>> stream) : super.from(stream);

  @override
  Future<void> content(T data) => super.accept(EntityState<T>.content(data));

  @override
  Future<void> error([Exception? exception, T? data]) =>
      super.accept(EntityState<T>.error(exception, data));

  @override
  Future<void> loading([T? previousData]) =>
      super.accept(EntityState<T>.loading(previousData));
}

/// State of some logical entity
class EntityState<T> {
  /// Data of entity
  final T? data;

  /// State is loading
  final bool isLoading;

  /// State has error
  final bool hasError;

  /// Exception from state
  final Exception? error;

  const EntityState({
    this.data,
    this.isLoading = false,
    this.hasError = false,
    this.error,
  });

  /// Loading constructor
  const EntityState.loading([this.data])
      : isLoading = true,
        hasError = false,
        error = null;

  /// Error constructor
  const EntityState.error([this.error, this.data])
      : isLoading = false,
        hasError = true;

  /// Content constructor
  const EntityState.content(this.data)
      : isLoading = false,
        hasError = false,
        error = null;
}
