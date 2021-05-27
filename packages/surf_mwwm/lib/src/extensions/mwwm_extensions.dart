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

import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_injector/surf_injector.dart';

/// Extensions for [WidgetModel]
extension SurfMwwmExtension on WidgetModel {
  /// bind ui [Event]'s
  StreamSubscription<T?> bind<T>(
    Event<T> event,
    void Function(T? value) onValue, {
    void Function(Object error)? onError,
  }) =>
      subscribe<T>(event.stream, onValue, onError: onError);
}

extension FutureExt<T> on Future<T> {
  /// Do future on specified listener
  ///
  /// ```dart
  /// await Future.value("wow").on(wm).then(result.add);
  /// await Future.value("rly").on(wm).then(result.add);
  /// ```
  Future<T> on(
    WidgetModel listener, {
    void Function(Object error)? onError,
  }) {
    final completer = Completer<T>();
    listener.doFuture<T>(
      this,
      completer.complete,
      onError: (e) {
        onError?.call(e);
        completer.completeError(e);
      },
    );

    return completer.future;
  }

  /// Do future with error catching on specified listener
  Future<T> withErrorHandling(WidgetModel listener) {
    final completer = Completer<T>();
    listener.doFutureHandleError<T>(
      this,
      completer.complete,
      onError: completer.completeError,
    );

    return completer.future;
  }
}

extension EventExt<T> on Event<T> {
  /// Bind one event to another
  Event<T> bind(void Function(T?) onData) {
    stream.doOnData(
      (t) {
        onData(t);
      },
    ).listen(null);

    return this;
  }

  /// Listen on specifited listener with possibility to add callbacks
  StreamSubscription<T?> listenOn(
    WidgetModel listener, {
    void Function(T? value)? onValue,
  }) {
    return listener.subscribe<T>(stream, onValue ?? (_) {});
  }
}

extension StreamX<T> on Stream<T> {
  /// Listen on specifited listener with possibility to add callbacks
  StreamSubscription<T?> listenOn(
    WidgetModel listener, {
    void Function(T? value)? onValue,
    void Function(Object error)? onError,
  }) {
    return listener.subscribe<T>(this, onValue ?? (_) {}, onError: onError);
  }

  /// Listen on WM with error catching
  StreamSubscription<T?> listenCatchError(
    WidgetModel listener, {
    void Function(T? value)? onValue,
    void Function(Object error)? onError,
  }) {
    return listener.subscribeHandleError<T>(
      this,
      onValue ?? (_) {},
      onError: onError,
    );
  }
}

extension InjectorExt on BuildContext {
  /// Getter for component by type
  T getComponent<T extends Component>() {
    return Injector.of<T>(this).component;
  }
}
