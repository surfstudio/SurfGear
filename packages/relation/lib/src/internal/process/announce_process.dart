import 'dart:async';

import 'package:relation/src/internal/process/process.dart';

/// Simple broadcast StreamController
class AnnounceProcess<T> extends Process<T> {
  /// Constructs a [AnnounceProcess]
  factory AnnounceProcess({
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) {
    // ignore: close_sinks
    final controller = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );

    return AnnounceProcess<T>._(
      controller,
      controller.stream,
    );
  }

  AnnounceProcess._(
    StreamController<T> controller,
    Stream<T> stream,
  ) : super(controller, stream);

  @override
  AnnounceProcess<R> createProcess<R>({
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) =>
      AnnounceProcess(
        onListen: onListen,
        onCancel: onCancel,
        sync: sync,
      );
}
