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

import 'package:relation/src/relation/event.dart';
import 'package:rxdart/rxdart.dart';

/// It's wrapper over an action on screen.
/// It may be a text changes, focus changes and so on.
///
/// It is **reactive**.
///
/// Usage:
/// ```
///   SomeWidget(
///     onValueChanged: someAction,
///   )
///
///   someAction.action.listen(doSomething);
/// ```
class StreamedAction<T> implements Event<T> {
  /// [acceptUnique] - data will be accepted only if it's unique
  StreamedAction({
    @Deprecated(
      'Use subscription on stream instead. And handle changes in listener. Will be removed in next major version',
    )
        this.onChanged,
    bool acceptUnique = false,
  }) : _acceptUnique = acceptUnique;

  final bool _acceptUnique;

  /// Publish subject for updating actions
  final _actionSubject = PublishSubject<T>();

  /// Callback for handling a new action
  @Deprecated(
    'Use subscription on stream instead. And handle changes in listener. Will be removed in next major version',
  )
  final void Function(T data)? onChanged;

  /// Data of action
  T? _value;

  @Deprecated(
    'Accept value to StreamedState instead and use its getter value. Will be removed in next major version',
  )
  T? get value => _value;

  @override
  Stream<T> get stream => _actionSubject.stream;

  @override
  Future<void> accept(T data) {
    if (!_acceptUnique || _value != data) {
      _value = data;
      _actionSubject.add(data);
      // ignore: deprecated_member_use_from_same_package
      onChanged?.call(data);
    }
    return Future.value();
  }

  /// Call action
  Future<void> call(T data) => accept(data);

  /// Close stream
  Future<void> dispose() => _actionSubject.close();
}

/// It's wrapper over an void action on screen.
/// It may be a tap action
///
/// It is **reactive**.
///
/// Usage:
/// ```
///   SomeWidget(
///     onTap: someAction,
///   )
///
///   someAction.action.listen(doSomething);
/// ```
class VoidAction extends Event<void> {
  VoidAction();

  /// Publish subject for updating actions
  final _actionSubject = PublishSubject<void>();

  @override
  Future<void> accept(void data) {
    _actionSubject.add(data);
    return Future.value();
  }

  @override
  Stream<void> get stream => _actionSubject.stream;

  /// Call action
  Future<void> call() => accept(null);

  /// Close stream
  Future<void> dispose() => _actionSubject.close();
}
