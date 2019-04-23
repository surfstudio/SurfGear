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

  /// subscribe for interactors
  void subscribe<T>(
    Observable<T> stream,
    void Function(T t) onValue, {
    void Function(dynamic e) onError,
  }) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      onError(e);
    });

    _compositeSubscription.add(subscription);
  }

  /// subscribe for interactors with default handle error
  void subscribeHandleError<T>(
    Observable<T> stream,
    void Function(T t) onValue, {
    void Function(dynamic e) onError,
  }) {
    StreamSubscription subscription = stream.listen(onValue, onError: (e) {
      handleError(e);
      onError(e);
    });

    _compositeSubscription.add(subscription);
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
  handleError(Object e) {
    _errorHandler.handleError(e);
    _errorSubject.add(ExceptionWrapper(e));
  }
}

class ExceptionWrapper {
  final Exception e;

  ExceptionWrapper(this.e);
}
