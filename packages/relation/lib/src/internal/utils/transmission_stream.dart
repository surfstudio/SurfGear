import 'dart:async';

import 'package:relation/src/internal/process/process.dart';
import 'package:relation/src/internal/utils/transmission_sink.dart';

/// Forwards events from incoming [Stream] to a new [StreamController]
Stream<R> forwardStream<T, R>(
  Stream<T> stream,
  TransmissionSink<T, R> linkedSink,
) {
  StreamController<R> controller;
  StreamSubscription<T> subscription;

  void catchError(void Function() func) {
    try {
      func();
    } on dynamic catch (e, s) {
      linkedSink.addError(controller, e, s);
    }
  }

  // ignore: prefer_function_declarations_over_variables
  final onListen = () {
    catchError(() => linkedSink.onListen(controller));

    subscription = stream.listen(
      (event) => catchError(() => linkedSink.add(controller, event)),
      // ignore: avoid_types_on_closure_parameters
      onError: (Object e, StackTrace s) => catchError(() => linkedSink.addError(controller, e, s)),
      onDone: () => catchError(() => linkedSink.close(controller)),
    );
  };

  // ignore: prefer_function_declarations_over_variables
  final onCancel = () {
    final onSelfCancel = subscription.cancel();
    final onCancelConnected = linkedSink.onCancel(controller);
    final futures = <Future>[
      if (onSelfCancel is Future) onSelfCancel,
      if (onCancelConnected is Future) onCancelConnected,
    ];

    return Future.wait<dynamic>(futures);
  };

  // ignore: prefer_function_declarations_over_variables
  final onPause = () {
    subscription.pause();
    catchError(() => linkedSink.onPause(controller));
  };

  // ignore: prefer_function_declarations_over_variables
  final onResume = () {
    subscription.resume();
    catchError(() => linkedSink.onResume(controller));
  };

  if (stream is Process<T>) {
    controller = stream.createProcess(
      onListen: onListen,
      onCancel: onCancel,
      sync: true,
    );
  } else if (stream.isBroadcast) {
    controller = StreamController<R>(
      onListen: onListen,
      onCancel: onCancel,
      sync: true,
    );
  } else {
    controller = StreamController<R>(
      onListen: onListen,
      onPause: onPause,
      onResume: onResume,
      onCancel: onCancel,
      sync: true,
    );
  }

  return controller.stream;
}
