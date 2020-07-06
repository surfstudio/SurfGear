import 'package:flutter_template/util/const.dart';
import 'package:string_mask/string_mask.dart';

class PhoneNumberUtil {
  static const String phonePrefix = "7";
  static const String defaultPattern = "+0 (000) 000 00 00";

  /// Возвращает только цифры из номера телефона
  /// 79801234567
  static String normalize(String inputString, {bool withPrefix = false}) {
    StringBuffer buff = StringBuffer();
    for (var i = 0; i < inputString.length; i++) {
      String o = inputString[i];
      if (int.tryParse(o) != null) {
        buff.write(o);
      }
    }

    String res = emptyString;
    if (withPrefix) {
      res += phonePrefix;
    }
    res += buff.toString();
    return res;
  }

  static String format(String input, {String pattern = defaultPattern}) {
    var mask = StringMask(pattern);
    return mask.apply(input);
  }
}
