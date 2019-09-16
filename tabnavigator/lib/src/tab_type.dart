import 'package:surf_util/surf_util.dart';

// todo think about needing on defaultType and values
// todo maybe we can make signature like this:
// todo ``` Enum<Widget> ``` ?
abstract class TabType extends Enum<int> {
  static List<TabType> values = List();

  static TabType defaultType;

  const TabType(int value) : super(value);

  static void create(TabType newTab) {
    values.add(newTab);
  }

  static TabType byValue(int ordinal) {
    return values.firstWhere(
      (value) => ordinal == value.value,
      orElse: () => throw Exception("Unknown TabType by ordinal $ordinal"),
    );
  }
}
