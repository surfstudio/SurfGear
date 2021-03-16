import 'package:meta/meta.dart';

/// Error holder for <RestorationProcess>
@immutable
class ErrorHolder {
  /// Creates a error holder instance
  const ErrorHolder(
      this.error,
      this.stackTrace,
      );

  /// Describes the error
  final Object error;

  /// Describes the information about [error]
  final StackTrace stackTrace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ErrorHolder &&
              error == other.error &&
              stackTrace == other.stackTrace &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode;

  @override
  String toString() => 'ErrorHolder(error: $error, stackTrace: $stackTrace)';
}
