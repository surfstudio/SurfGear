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
import 'package:surf_injector/surf_injector.dart';
import 'package:rxdart/rxdart.dart';

/// Extensions for [WidgetModel]
extension SurfMwwmExtension on WidgetModel {
  /// bind ui [Event]'s
  void bind<T>(
    Event<T> event,
    void Function(T? t) onValue, {
    void Function(dynamic e)? onError,
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
  Future<T> on(WidgetModel listener, {void Function(Object e)? onError}) {
    Completer<T> completer = Completer();
    listener.doFuture<T>(
      this,
      (data) {
        completer.complete(data);
      },
      onError: (e) {
        onError?.call(e);
        completer.completeError(e);
      },
    );

    return completer.future;
  }

  /// Do future with error catching on specified listener
  Future<T> withErrorHandling(WidgetModel listener) {
    Completer<T> _c = Completer();
    listener.doFutureHandleError<T>(this, (data) {
      _c.complete(data);
    }, onError: (e) {
      _c.completeError(e);
    });

    return _c.future;
  }
}

extension EntityExt<T> on EntityStreamedState<T> {
  /// Map streamed state by specified function
  EntityStreamedState<R> map<R>(R Function(T) mapper) =>
      EntityStreamedState<R>.from(
        this.stream.map(
          (es) {
            if (es!.isLoading) {
              return EntityState<R>.loading();
            } else if (es.hasError) {
              return EntityState<R>.error(es.error);
            } else {
              return EntityState<R>.content(mapper(es.data!));
            }
          },
        ),
      );
}

extension EventExt<T> on Event<T> {
  /// Transform streamed event with soecified function
  Event<R> map<R>(R Function(T?) mapper) =>
      StreamedState<R>.from(this.stream.map(mapper));

  /// Do function on action triggered
  Event<T> doOnData(void Function(T?) action) {
    return this..stream.doOnData(action);
  }

  /// Do something on each event on stream
  Event<T> doEventOnData(Event<T?> event) {
    return this..stream.doOnData(event.accept);
  }

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
  void listenOn(
    WidgetModel listener, {
    required void Function(T?) onValue,
    void Function(dynamic e)? onError,
  }) {
    listener.subscribe<T>(this.stream, onValue, onError: onError);
  }

  /// Listen on WM with error catching
  void listenCathError(
    WidgetModel listener, {
    required void Function(T?) onValue,
    void Function(dynamic e)? onError,
  }) {
    this.stream.listenCatchError(listener, onValue: onValue, onError: onError);
  }
}

extension StreamX<T> on Stream<T> {
  /// Listen on specifited listener with possibility to add callbacks
  void listenOn(
    WidgetModel listener, {
    required void Function(T?) onValue,
    void Function(dynamic e)? onError,
  }) {
    listener.subscribe<T>(this, onValue, onError: onError);
  }

  /// Listen on WM with error catching
  void listenCatchError(
    WidgetModel listener, {
    required void Function(T?) onValue,
    void Function(dynamic e)? onError,
  }) {
    listener.subscribeHandleError<T>(this, onValue, onError: onError);
  }
}

extension InjectorExt on BuildContext {
  /// Getter for component by type
  T getComponent<T extends Component>() {
    return Injector.of<T>(this).component;
  }
}
