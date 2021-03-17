import 'dart:async';

import 'package:relation/src/internal/process/process.dart';
import 'package:relation/src/internal/streams/delay_stream.dart';
import 'package:relation/src/internal/streams/restoration_stream.dart';
import 'package:relation/src/internal/transformers/init_with.dart';
import 'package:relation/src/internal/transformers/init_with_error.dart';
import 'package:relation/src/internal/utils/error_holder.dart';
import 'package:relation/src/internal/utils/restoration_holder.dart';
import 'package:relation/src/internal/utils/value_holder.dart';

/// Stream controller, that captures last emitted item
class RestorationProcess<T> extends Process<T> implements RestorationStream<T> {
  /// Creates a [RestorationProcess]
  factory RestorationProcess({
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) {
    final controller = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );

    final restorationHolder = RestorationHolder<T>();

    return RestorationProcess<T>._(
      controller,
      DelayStream<T>(_streamFactory(controller, restorationHolder)),
      restorationHolder,
    );
  }

  /// Creates a [RestorationProcess]
  ///
  /// emits [initial] immediately
  factory RestorationProcess.initial(
    T initial, {
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) {
    final controller = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );

    final restorationHolder = RestorationHolder<T>.initial(initial);

    return RestorationProcess<T>._(
      controller,
      DelayStream<T>(_streamFactory(controller, restorationHolder)),
      restorationHolder,
    );
  }

  RestorationProcess._(
    StreamController<T> controller,
    this._stream,
    this._restorationHolder,
  ) : super(controller, _stream);

  final Stream<T> _stream;
  final RestorationHolder<T> _restorationHolder;

  static StreamFactory<T> _streamFactory<T>(
    StreamController<T> controller,
    RestorationHolder<T> restorationHolder,
  ) =>
      () {
        if (restorationHolder.hasError) {
          final errorHolder = restorationHolder.errorHolder;
          return controller.stream.transform(
            InitWithErrorStreamTransformer(
              errorHolder.error,
              errorHolder.stackTrace,
            ),
          );
        }

        if (restorationHolder.hasValue) {
          return controller.stream.transform(
            InitWithStreamTransformer(
              restorationHolder.valueHolder.value,
            ),
          );
        }

        return controller.stream;
      };

  @override
  Stream<T> get stream => this;

  @override
  ValueHolder<T> get valueHolder => _restorationHolder.valueHolder;

  @override
  ErrorHolder get errorHolder => _restorationHolder.errorHolder;

  @override
  void onAdd(T event) {
    _restorationHolder.setValue(event);
  }

  @override
  void onAddError(Object error, [StackTrace stackTrace]) {
    _restorationHolder.setError(error, stackTrace);
  }

  @override
  RestorationStream<T> where(bool Function(T event) test) =>
      _forwardRestorationProcess<T>((s) => s.where(test));

  @override
  RestorationStream<S> map<S>(S Function(T event) convert) =>
      _forwardRestorationProcess<S>((s) => s.map(convert));

  @override
  RestorationStream<E> asyncMap<E>(FutureOr<E> Function(T event) convert) =>
      _forwardRestorationProcess<E>((s) => s.asyncMap(convert));

  @override
  RestorationStream<E> asyncExpand<E>(Stream<E> Function(T event) convert) =>
      _forwardRestorationProcess<E>((s) => s.asyncExpand(convert));

  @override
  RestorationStream<T> handleError(Function onError,
          // ignore: avoid_annotating_with_dynamic
          {bool Function(dynamic) test}) =>
      _forwardRestorationProcess<T>((s) => s.handleError(onError, test: test));

  @override
  RestorationStream<S> expand<S>(Iterable<S> Function(T) convert) =>
      _forwardRestorationProcess<S>((s) => s.expand(convert));

  @override
  RestorationStream<S> transform<S>(StreamTransformer<T, S> streamTransformer) =>
      _forwardRestorationProcess<S>((s) => s.transform(streamTransformer));

  @override
  RestorationStream<R> cast<R>() => _forwardRestorationProcess<R>((s) => s.cast<R>());

  @override
  RestorationStream<T> take(int count) => _forwardRestorationProcess<T>((s) => s.take(count));

  @override
  RestorationStream<T> takeWhile(bool Function(T) test) =>
      _forwardRestorationProcess<T>((s) => s.takeWhile(test));

  @override
  RestorationStream<T> skip(int count) => _forwardRestorationProcess<T>((s) => s.skip(count));

  @override
  RestorationStream<T> skipWhile(bool Function(T) test) =>
      _forwardRestorationProcess<T>((s) => s.skipWhile(test));

  @override
  RestorationStream<T> distinct([bool Function(T, T) equals]) =>
      _forwardRestorationProcess<T>((s) => s.distinct(equals));

  @override
  RestorationStream<T> timeout(Duration timeLimit, {void Function(EventSink<T>) onTimeout}) =>
      _forwardRestorationProcess<T>((s) => s.timeout(timeLimit, onTimeout: onTimeout));

  @override
  RestorationProcess<R> createProcess<R>({
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) =>
      RestorationProcess<R>(
        onListen: onListen,
        onCancel: onCancel,
        sync: sync,
      );

  RestorationStream<R> _forwardRestorationProcess<R>(
    Stream<R> Function(Stream<T>) transformerStream,
  ) {
    RestorationProcess<R> process;
    StreamSubscription<R> subscription;

    // ignore: prefer_function_declarations_over_variables
    final onListen = () => subscription = transformerStream(_stream).listen(
          process.add,
          onError: process.addError,
          onDone: process.close,
        );
    // ignore: prefer_function_declarations_over_variables
    final onCancel = () => subscription.cancel();

    return process = RestorationProcess<R>(
      onListen: onListen,
      onCancel: onCancel,
      sync: true,
    );
  }
}
