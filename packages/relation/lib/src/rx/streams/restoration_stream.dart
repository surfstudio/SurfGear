import 'package:relation/src/rx/utils/error_holder.dart';
import 'package:relation/src/rx/utils/value_holder.dart';

/// [Stream] that provides sync access to the last item
abstract class RestorationStream<T> implements Stream<T> {
  /// Last emitted value
  ValueHolder<T> get valueHolder;

  /// Last emitted error
  ErrorHolder get errorHolder;
}

/// Extension for access value or error
extension RestoreationStreamExtension<T> on RestorationStream<T> {
  /// A flag that describes if there is a value
  bool get hasValue => valueHolder != null;

  /// Returns last emitted value, or null if there is no value
  T get value => valueHolder?.value;

  /// Returns last emitted value, fails if there is no value
  T get requireValue {
    if (valueHolder != null) {
      return valueHolder.value;
    }

    if (errorHolder != null) {
      throw Exception(errorHolder.error);
    }

    throw StateError('There is no data or error');
  }

  /// A flag that describes if there is an error
  bool get hasError => errorHolder != null;

  /// Returns last emitted error, or null if there is no error
  Object get error => errorHolder?.error;

  /// Returns last emitted error, fails if there is no error
  Object get requireError {
    if (errorHolder != null) {
      throw Exception(errorHolder.error);
    }

    if (hasValue) {
      throw StateError('Last emitted item is not an error');
    }

    throw StateError('There is no data or error');
  }
}
