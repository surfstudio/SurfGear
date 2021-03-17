import 'dart:async';

/// [Sink] that supports event hooks for transformers
abstract class TransmissionSink<T, R> {
  /// Handle data
  void add(EventSink<R> sink, T data);

  /// Handle error
  void addError(EventSink<R> sink, Object error, [StackTrace stackTrace]);

  /// Handle close
  void close(EventSink<R> sink);

  /// Triggers when a listener subscribes on the [Stream]
  void onListen(EventSink<R> sink);

  /// Triggers when a subscriber pauses
  void onPause(EventSink<R> sink);

  /// Triggers when a subscriber resumes
  void onResume(EventSink<R> sink);

  /// Triggers when a subscriber cancels
  FutureOr onCancel(EventSink<R> sink);
}
