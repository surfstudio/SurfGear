import 'package:surf_util/src/enum/bitmask.dart';

extension BitmaskIntExtension on int {
  bool isOn(Bitmask mask) => mask.isOn(this);
}
