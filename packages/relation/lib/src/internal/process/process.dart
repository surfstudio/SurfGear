import 'dart:async';

/// Base class for streams
abstract class Process<T> extends StreamView<T> implements StreamController<T> {
  /// Creates process which wraps a controller
  Process(StreamController<T> controller, Stream<T> stream)
      : _controller = controller,
        super(stream);

  final StreamController<T> _controller;

  var _isAddingFromStream = false;

  @override
  Stream<T> get stream => this;

  @override
  void Function() get onListen => _controller.onListen;

  @override
  set onListen(void Function() onListenHandler) {
    _controller.onListen = onListenHandler;
  }

  @override
  void Function() get onPause {
    throw UnsupportedError('Process do not support onPause');
  }

  @override
  set onPause(void Function() onPauseHandler) {
    throw UnsupportedError('Process do not support onPause');
  }

  @override
  void Function() get onResume {
    throw UnsupportedError('Process do not support onResume');
  }

  @override
  set onResume(void Function() onResumeHandler) {
    throw UnsupportedError('Process do not support onResume');
  }

  @override
  FutureOr<void> Function() get onCancel => _controller.onCancel;

  @override
  set onCancel(FutureOr<void> Function() onCancelHandler) {
    _controller.onCancel = onCancelHandler;
  }

  @override
  StreamSink<T> get sink => _controller.sink;

  @override
  bool get isClosed => _controller.isClosed;

  @override
  bool get isPaused => _controller.isPaused;

  @override
  bool get hasListener => _controller.hasListener;

  @override
  void add(T event) {
    _checkState();
    _add(event);
  }

  void _add(T event) {
    onAdd(event);
    _controller.add(event);
  }

  /// Perform side effects when new value added
  void onAdd(T event) {}

  @override
  void addError(Object error, [StackTrace stackTrace]) {
    _checkState();

    _addError(error, stackTrace);
  }

  void _addError(Object error, [StackTrace stackTrace]) {
    onAddError(error, stackTrace);
    _controller.addError(error, stackTrace);
  }

  /// Perform side effects when new error added
  void onAddError(Object error, [StackTrace stackTrace]) {}

  @override
  Future close() {
    _checkState();

    return _controller.close();
  }

  @override
  Future get done => _controller.done;

  @override
  Future addStream(Stream<T> source, {bool cancelOnError = false}) {
    _checkState();

    final completer = Completer<void>();
    var isOnDoneCalled = false;
    // ignore: prefer_function_declarations_over_variables
    final onDone = () {
      if (!isOnDoneCalled) {
        completer.complete();
        _isAddingFromStream = false;
        isOnDoneCalled = true;
      }
    };

    _isAddingFromStream = true;
    source.listen(
      _add,
      // ignore: avoid_types_on_closure_parameters
      onError: (Object error, StackTrace stackTrace) {
        _addError(error, stackTrace);
        if (cancelOnError ?? false) onDone();
      },
      cancelOnError: cancelOnError ?? false,
      onDone: onDone,
    );

    return completer.future;
  }

  void _checkState() {
    if (_isAddingFromStream) {
      throw StateError('Can not add value or error while items is adding from addStream');
    }
  }

  /// Creates same process
  Process<R> createProcess<R>({
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  });
}
