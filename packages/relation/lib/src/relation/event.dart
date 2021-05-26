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

/// An event that can take some value
abstract class Event<T> {
  const Event();

  /// The stream to which the event is transmitted
  Stream<T> get stream;

  /// Acceptance of a new event
  Future<void> accept(T data);
}

/// An event that has multiple States
abstract class EntityEvent<T, E> {
  const EntityEvent();

  /// Acceptance of a new entity event
  Future<void> content(T data);

  /// Setting the event data is loading
  Future<void> loading();

  /// Setting the event data is error
  Future<void> error([Exception? error]);
}
