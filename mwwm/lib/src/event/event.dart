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

import 'package:rxdart/rxdart.dart';

///Событие, которое может принимать некоторое значение
abstract class Event<T> {
  Observable get stream;

  Future<void> accept([T data]);
}

///Событие, которое имеет несколько состояний
abstract class EntityEvent<T> {
  Future<void> content([T data]);

  Future<void> loading();

  Future<void> error([Exception error]);
}
