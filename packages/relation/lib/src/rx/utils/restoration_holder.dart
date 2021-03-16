import 'package:relation/src/rx/utils/error_holder.dart';
import 'package:relation/src/rx/utils/value_holder.dart';

/// Holds last value or error for <RestorationProcess>
class RestorationHolder<T> {
  /// Creates empty restoration holder
  RestorationHolder();

  /// Creates restoration holder with initial value
  RestorationHolder.initial(T value) : valueHolder = ValueHolder<T>(value);

  /// Describes last emitted value
  ValueHolder<T> valueHolder;

  /// Describes last emitted error
  ErrorHolder errorHolder;

  /// Specify last emitted value
  void setValue(T value) {
    valueHolder = ValueHolder<T>(value);
    errorHolder = null;
  }

  /// Specify last emitted error
  void setError(Object error, [StackTrace stackTrace]) {
    errorHolder = ErrorHolder(error, stackTrace);
    valueHolder = null;
  }

  /// A flag that describes if there is a value
  bool get hasValue => valueHolder != null;

  /// A flag that describes if there is an error
  bool get hasError => errorHolder != null;
}
