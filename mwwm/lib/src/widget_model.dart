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

import 'package:meta/meta.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/error/error_handler.dart';
import 'package:rxdart/rxdart.dart';

///WidgetModel - interface
///WM is logical representation of widget.
///Has Action as input 
///and StreamedState(and descedants) as output
abstract class WidgetModel {
  final ErrorHandler _errorHandler;
  CompositeSubscription _compositeSubscription = CompositeSubscription();
  PublishSubject<ExceptionWrapper> _errorSubject = PublishSubject();

  Observable<ExceptionWrapper> get errorStream => _errorSubject.stream;

  WidgetModel(WidgetModelDependencies baseDependencies)
      : _errorHandler = baseDependencies.errorHandler {
    onLoad();
  }

  @mustCallSuper
  void onLoad() {}

  /// subscribe for interactors
  StreamSubscription subscribe<T>(
    Observable<T> stream,
    void Function(T t) onValue, {
    void Function(dynamic e) onError,
  }) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      onError?.call(e);
    });

    _compositeSubscription.add(subscription);
    return subscription;
  }

  /// subscribe for interactors with default handle error
  StreamSubscription subscribeHandleError<T>(
    Observable<T> stream,
    void Function(T t) onValue, {
    void Function(dynamic e) onError,
  }) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      handleError(e);
      onError?.call(e);
    });

    _compositeSubscription.add(subscription);
    return subscription;
  }

  /// Call a future.
  /// Using Rx wrappers with [subscribe] method is preferable.
  void doFuture<T>(
    Future<T> future,
    onValue(T t), {
    onError(e),
  }) {
    future.then(onValue).catchError((e) {
      onError?.call(e);
    });
  }

  /// Call a future with default error handling
  void doFutureHandleError<T>(
    Future<T> future,
    onValue(T t), {
    onError(e),
  }) {
    future.then(onValue).catchError((e) {
      handleError(e);
      onError?.call(e);
    });
  }

  /// bind ui [Event]'s
  void bind<T>(
    Event<T> event,
    void Function(T t) onValue, {
    void Function(dynamic e) onError,
  }) =>
      subscribe<T>(event.stream, onValue, onError: onError);

  /// Close streams of WM
  dispose() {
    _compositeSubscription.dispose();
  }

  /// standard error handling
  @protected
  handleError(dynamic e) {
    _errorHandler.handleError(e);
    _errorSubject.add(ExceptionWrapper(e));
  }
}

class ExceptionWrapper {
  final dynamic e;

  ExceptionWrapper(this.e);
}