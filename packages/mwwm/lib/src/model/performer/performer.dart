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

import 'package:mwwm/mwwm.dart';

/// Performer handles a specific [Change].
/// It's a key component in the relationship between WidgetModel
/// that requests some data, and the source of these data.
/// R - type of result
/// C - type of change on which performer triggers
abstract class Performer<R, C extends Change<R>> {
  Performer();

  factory Performer.from(FunctionalPerformer<R, C> _performerFunc) =>
      _Performer(_performerFunc);

  /// Main method to perform a Change
  /// 
  /// Here placed a logic to react to change. There can be 
  /// request to a server or something else.
  /// 
  /// This method use Model when perform change.
  /// 
  /// Typically don't use directly
  R perform(C change);

  /// Method to check ability to perform a object
  /// c - can be anything
  /// 
  /// Typically used only in Model
  bool canPerform(Object c) => c is C;
}

typedef FunctionalPerformer<R, C> = R Function(C);

class _Performer<R, C extends Change<R>> extends Performer<R, C> {
  final FunctionalPerformer<R, C> _performerFunc;

  _Performer(this._performerFunc);

  @override
  R perform(C change) {
    return _performerFunc(change);
  }
}

/// Alias for performers which result is a Future with data
/// This operations do only once
abstract class FuturePerformer<R, C extends FutureChange<R>>
    extends Performer<Future<R>, C> {
  FuturePerformer();
}

/// Alias for performers that return Stream of data
/// Recommended for observabling data
abstract class StreamPerformer<R, C extends StreamChange<R>>
    extends Performer<Stream<R>, C> {
  StreamPerformer();
}

/// Broadcast is a [Performer] that allows listening to
/// results of [perform].
/// R - type of result
/// C - type of change on which performer triggers
abstract class Broadcast<R, C extends FutureChange<R>>
    extends FuturePerformer<R, C> {
  final _controller = StreamController<R>.broadcast();

  /// Stream of results of [perform].
  Stream<R> get broadcast => _controller.stream;

  @override
  Future<R> perform(C change) {
    var result = performInternal(change);
    _addBroadcast(result);
    return result;
  }

  Future<R> performInternal(C change);

  void _addBroadcast(Future<R> result) {
    _controller.addStream(result.asStream());
  }
}
