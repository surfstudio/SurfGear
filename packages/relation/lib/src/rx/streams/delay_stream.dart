import 'dart:async';

typedef StreamFactory<T> = Stream<T> Function();

/// Waits until a listener subscribes to it, and then it creates
/// a stream with given factory
class DelayStream<T> extends Stream<T> {
  /// Constructs [Stream] lazily
  DelayStream(this._factory);

  final StreamFactory<T> _factory;

  @override
  StreamSubscription<T> listen(
    void Function(T event) onData, {
    Function onError,
    void Function() onDone,
    bool cancelOnError,
  }) {
    Stream<T> stream;

    try {
      stream = _factory();
      return stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
    } on dynamic catch (e, s) {
      return Stream<T>.error(e, s).listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
    }
  }
}
