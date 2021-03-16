import 'dart:async';

import 'package:relation/src/rx/utils/transmission_sink.dart';
import 'package:relation/src/rx/utils/transmission_stream.dart';

class _InitWithStreamSink<T> implements TransmissionSink<T, T> {
  _InitWithStreamSink(this._initValue);

  final T _initValue;
  var _isInitValueAdded = false;

  @override
  void add(EventSink<T> sink, T data) {
    _addInitValue(sink);
    sink.add(data);
  }

  @override
  void addError(EventSink<T> sink, Object error, [StackTrace stackTrace]) {
    _addInitValue(sink);
    sink.addError(error, stackTrace);
  }

  @override
  void close(EventSink<T> sink) {
    _addInitValue(sink);
    sink.close();
  }

  @override
  FutureOr onCancel(EventSink<T> sink) {}

  @override
  void onListen(EventSink<T> sink) {
    scheduleMicrotask(() => _addInitValue(sink));
  }

  @override
  void onPause(EventSink<T> sink) {}

  @override
  void onResume(EventSink<T> sink) {}

  void _addInitValue(EventSink<T> sink) {
    if (_isInitValueAdded) return;
    sink.add(_initValue);
    _isInitValueAdded = true;
  }
}

/// Inserts a value to the source [Stream]
class InitWithStreamTransformer<T> extends StreamTransformerBase<T, T> {
  /// Constructs a [StreamTransformer] which inserts [initValue] to the source [Stream]
  InitWithStreamTransformer(this.initValue);

  /// Initial value of this [Stream]
  final T initValue;

  @override
  Stream<T> bind(Stream<T> stream) => forwardStream(stream, _InitWithStreamSink<T>(initValue));
}

/// Gives ability to emit the value as the first item
extension InitWithExtension<T> on Stream<T> {
  /// Inserts a value to the source [Stream]
  Stream<T> initWith(T initValue) => transform(InitWithStreamTransformer<T>(initValue));
}
