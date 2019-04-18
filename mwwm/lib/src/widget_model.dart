import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:mwwm/mwwm.dart';
import 'package:rxdart/rxdart.dart';

///WidgetModel - interface
///WM is logical representation of widget.
///полностью на action/stream | action/observable
abstract class WidgetModel {
  final ErrorHandler _errorHandler;
  final NavigatorState _navigator;
  CompositeSubscription _compositeSubscription = CompositeSubscription();
  PublishSubject<ExceptionWrapper> _errorSubject = PublishSubject();

  Observable<ExceptionWrapper> get errorStream => _errorSubject.stream;

  WidgetModel(WidgetModelDependencies baseDependencies)
      : _errorHandler = baseDependencies.errorHandler,
        _navigator = baseDependencies.navigator {
    onLoad();
  }

  void onLoad() {}

  void listenToStream<T>(Observable<T> stream, void Function(T t) onValue,
      {onError(e)}) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      handleError(e);
      onError(e);
    });

    _compositeSubscription.add(subscription);
  }

  void doFuture<T>(Future<T> future, onValue(T t), {onError(e)}) {
    future.then(onValue).catchError((e) {
      onError(e);
    });
  }

  void doFutureHandleError<T>(Future<T> future, onValue(T t), {onError(e)}) {
    future.then(onValue).catchError((e) {
      handleError(e);
      onError(e);
    });
  }

  /// Close streams of WM
  dispose() {
    _compositeSubscription.dispose();
  }

  /// standard error handling
  @protected
  handleError(Object e) {
    _errorHandler.handleError(e);
    _errorSubject.add(ExceptionWrapper(e));
  }
}

class ExceptionWrapper {
  final Exception e;

  ExceptionWrapper(this.e);
}
