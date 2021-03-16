import 'dart:async';

import 'package:relation/src/rx/utils/transmission_sink.dart';
import 'package:relation/src/rx/utils/transmission_stream.dart';

class _InitWithErrorStreamSink<T> implements TransmissionSink<T, T> {
  _InitWithErrorStreamSink(this._error, this._stackTrace);

  final Object _error;
  final StackTrace _stackTrace;
  var _isInitErrorAdded = false;

  @override
  void add(EventSink<T> sink, T data) {
    _addInitError(sink);
    sink.add(data);
  }

  @override
  void addError(EventSink<T> sink, Object error, [StackTrace stackTrace]) {
    _addInitError(sink);
    sink.addError(error, stackTrace);
  }

  @override
  void close(EventSink<T> sink) {
    _addInitError(sink);
    sink.close();
  }

  @override
  FutureOr onCancel(EventSink<T> sink) {}

  @override
  void onListen(EventSink<T> sink) {
    scheduleMicrotask(() => _addInitError(sink));
  }

  @override
  void onPause(EventSink<T> sink) {}

  @override
  void onResume(EventSink<T> sink) {}

  void _addInitError(EventSink<T> sink) {
    if (_isInitErrorAdded) return;
    sink.addError(_error, _stackTrace);
    _isInitErrorAdded = true;
  }
}

/// Inserts an error to the source [Stream]
class InitWithErrorStreamTransformer<T> extends StreamTransformerBase<T, T> {
  /// Constructs a [StreamTransformer] which inserts
  /// [error] and [stackTrace] to the source [Stream]
  InitWithErrorStreamTransformer(this.error, this.stackTrace);

  /// Initial error of this [Stream]
  final Object error;

  /// Initial stackTrace of this [Stream]
  final StackTrace stackTrace;

  @override
  Stream<T> bind(Stream<T> stream) =>
      forwardStream(stream, _InitWithErrorStreamSink<T>(error, stackTrace));
}

/// Gives ability to emit the error as the first item
extension InitWithError<T> on Stream<T> {
  /// Inserts an [error] and [stackTrace] to the source [Stream]
  Stream<T> initWithError([Object error, StackTrace stackTrace]) =>
      transform(InitWithErrorStreamTransformer<T>(error, stackTrace));
}
