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

import 'package:relation/src/relation/relation_event.dart';
import 'package:rxdart/rxdart.dart';

/// [RelAction] stands for Relation Action
/// It's wrapper over an action on screen.
/// It may be a tap on button, text changes, focus changes and so on.
/// [onChanged] - callback for [accept]'s or [call]'s call
/// `acceptUnique` - data will be accepted only if it's unique
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
class RelAction<T> implements RelEvent<T> {
  RelAction({
    void Function(T? data)? onChanged,
    bool acceptUnique = false,
  })  : onChanged = onChanged ?? ((_) {}),
        _acceptUnique = acceptUnique;

  /// When switched on, data will be
  /// accepted only if it's unique
  final bool _acceptUnique;

  /// Publish subject for updating actions
  final _actionSubject = PublishSubject<T?>();

  /// Callback for handling a new action
  final void Function(T? data) onChanged;

  /// Data of action
  T? _value;
  T? get value => _value;

  @override
  Stream<T?> get stream => _actionSubject.stream;

  @override
  Future<T?> accept([T? data]) async {
    if (_acceptUnique && _value == data) {
      return _value;
    } else {
      _value = data;
      _actionSubject.add(_value);
      onChanged(_value);
      return _value;
    }
  }

  /// Call action
  Future<T?> call([T? data]) => accept(data);

  /// Close stream
  Future<void> dispose() => _actionSubject.close();
}
