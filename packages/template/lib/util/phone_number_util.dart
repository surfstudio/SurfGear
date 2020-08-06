// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter_template/util/const.dart';
import 'package:string_mask/string_mask.dart';

class PhoneNumberUtil {
  static const String phonePrefix = '7';
  static const String defaultPattern = '+0 (000) 000 00 00';

  /// Возвращает только цифры из номера телефона
  /// 79801234567
  static String normalize(String inputString, {bool withPrefix = false}) {
    final StringBuffer buff = StringBuffer();
    for (var i = 0; i < inputString.length; i++) {
      final String o = inputString[i];
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
    final mask = StringMask(pattern);
    return mask.apply(input);
  }
}
