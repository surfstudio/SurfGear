import 'dart:async';
import 'package:flutter/foundation.dart';
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
        _initErrorHandler();
        onLoad();
    }

    ///В будущем проекте call super
    @protected
    void onLoad() => onBind();

    @protected
    void onBind() {}

    /// subscribe for interactors
    StreamSubscription subscribe<T>(Observable<T> stream,
        void Function(T t) onValue, {
            void Function(dynamic e) onError,
        }) {
        StreamSubscription subscription = stream.listen(onValue, onError: (e) {
            if (onError != null) onError(e);
        });

        _compositeSubscription.add(subscription);
        return subscription;
    }

    /// subscribe for interactors with default handle error
    StreamSubscription subscribeHandleError<T>(Observable<T> stream,
        void Function(T t) onValue, {
            void Function(dynamic e) onError,
        }) {
        StreamSubscription subscription = stream.listen(onValue, onError: (e) {
            handleError(e);
            if (onError != null) onError(e);
        });

        _compositeSubscription.add(subscription);
        return subscription;
    }

    /// bind ui [Event]'s
    void bind<T>(Event<T> event,
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
        _errorSubject.add(ExceptionWrapper(e));
    }

    void _initErrorHandler() {
        subscribe<ExceptionWrapper>(
            _errorSubject.throttleTime(Duration(seconds: 4)),
                (error) => _errorHandler.handleError(error.e),
        );
    }
}

class ExceptionWrapper {
    final dynamic e;

    ExceptionWrapper(this.e);
}
