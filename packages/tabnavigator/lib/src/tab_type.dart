import 'package:surf_util/surf_util.dart';

/// base type for a list of tabs
/// adding new types of tabs via the create() method
abstract class TabType extends Enum<int> {
  const TabType(int value) : super(value);

  static List<TabType> values = [];

  static TabType defaultType;

  static void create(TabType newTab) {
    values.add(newTab);
  }

  static TabType byValue(int ordinal) {
    return values.firstWhere(
      (value) => ordinal == value.value,
      orElse: () => throw Exception('Unknown TabType by ordinal $ordinal'),
    );
  }
}
