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
import 'package:relation/src/rx/rx.dart';

/// A state of some type wrapped in a stream
/// dictates the widget's state
///
/// It is **reactive**.
///
/// Usage:
/// ```
///   StreamedStateBuilder<T>(
///     streamedState: yourStreamedState,
///     builder: (ctx, T data) => Text(data.toString()),
///   )
/// ```
class StreamedState<T> implements Event<T> {
  StreamedState([T initialData]) {
    if (initialData != null) {
      accept(initialData);
    }
  }

  StreamedState.from(Stream<T> stream) {
    stateProcess.addStream(stream);
  }

  /// Behavior state for updating events
  final RestorationProcess<T> stateProcess = RestorationProcess();

  /// current value in stream
  T get value => stateProcess.value;

  @override
  Stream<T> get stream => stateProcess.stream;

  @override
  Future<void> accept([T data]) {
    stateProcess.add(data);
    return stateProcess.stream.first;
  }

  void dispose() {
    stateProcess.close();
  }
}
