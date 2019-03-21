import 'dart:async';

import 'package:rxdart/rxdart.dart';

///WidgetModel - interface
///WM is logical representation of widget.
///полностью на action/stream | action/observable
abstract class WidgetModel {
  CompositeSubscription _compositeSubscription = CompositeSubscription();
  PublishSubject<Exception> _errorSubject = PublishSubject();

  Observable<Exception> get errorStream => _errorSubject.stream;

  void listenToStream<T>(Observable<T> stream, onValue(T t), {onError(e)}) {
    StreamSubscription susbcription = stream.listen(onValue, onError: (e) {
      _handleError(e);
      onError(e);
    });

    _compositeSubscription.add(susbcription);
  }

  void doFuture<T>(Future<T> future, onValue(T t), {onError(e)}) {
    future.then(onValue).catchError((e) {
      print(e);
      _handleError(e);
      onError(e);
    });
  }

  /// Close streams of WM
  dispose() {
    _compositeSubscription.dispose();
  }

  /// standard error handling
  _handleError(Exception e) {
    //todo сделать сдандуртную обработку
    print("DEV_ERROR ${e.toString()}");
    _errorSubject.add(e);
  }
}
