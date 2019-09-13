/// Java-like enum
/// При реализации стоит также создать статический метод byValue,
/// возвращающий один из объектов класса.
///
/// Пример использования:
/// ```dart
/// class TransactionType extends Enum<String> {
///   const TransactionType(String val) : super(val);
///
///   static const TransactionType IN = TransactionType('in');
///   static const TransactionType OUT = TransactionType('out');
///
///   static TransactionType byValue(String value) {
///     switch (value) {
///       case 'in':
///         return IN;
///       case 'out':
///         return OUT;
///       default:
///         return OUT;
///     }
///   }
/// }
/// ```
abstract class Enum<T> {
  final T value;

  const Enum(this.value);
}
