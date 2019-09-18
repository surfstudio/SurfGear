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

import 'dart:async';

import 'package:mwwm/src/relation/event/event.dart';
import 'package:rxdart/rxdart.dart';

/// Action
/// It's wrapper over an action on screen.
/// It may be a tap on button, text changes, focus changes and so on.
///
/// It is **reactive**.
///
/// Usage:
/// ```
///   SomeWidget(
///     onTap: someAction.accept,
///   )
///
///   someAction.action.listen(doSomething);
/// ```
class Action<T> implements Event<T> {
  PublishSubject<T> _actionSubject = PublishSubject();
  final void Function(T data) onChanged;
  T value;

  @override
  Observable<T> get stream => _actionSubject.stream;

  Subject<T> get subject => _actionSubject;

  Action([void Function(T data) onChanged])
      : this.onChanged = onChanged ?? ((a) {});

  @override
  Future<void> accept([T data]) async {
    value = data;
    _actionSubject.add(data);
    onChanged(value);
    return _actionSubject.stream.first.wrapped;
  }

  call([T data]) => accept(data);

  /// Close stream
  void dispose() {
    _actionSubject.close();
  }
}
