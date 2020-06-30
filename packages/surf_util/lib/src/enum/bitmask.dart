import '../../surf_util.dart';

/// Реализация Enum в виде битовой маски.
/// Каждое значение перечисления должно быть степенью двойки.
abstract class Bitmask extends Enum<int> {
  const Bitmask(int value)
      : assert(value > 0 && (value & (value - 1) == 0)),
        super(value);

  /// Возвращает значение маски по списку значений
  static int getMask(Iterable<Bitmask> list) {
    var res = 0;
    list.forEach((e) => res = res | e.value);

    return res;
  }

  /// Выполняет проверку на активность флага.
  bool isOn(int mask) {
    return (mask & value) != 0;
  }
}
