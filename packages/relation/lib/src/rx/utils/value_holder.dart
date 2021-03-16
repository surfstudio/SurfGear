import 'package:meta/meta.dart';

/// Value holder for <RestorationProcess>
@immutable
class ValueHolder<T> {
  /// Creates a value holder instance
  const ValueHolder(this.value);

  /// Value of stream type
  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ValueHolder && value == other.value && runtimeType == other.runtimeType;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ValueHolder(value: $value)';
}
