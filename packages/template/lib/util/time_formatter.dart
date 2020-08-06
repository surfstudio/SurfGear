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

import 'package:flutter_template/domain/time.dart';
import 'package:flutter_template/ui/res/strings/common_strings.dart';
import 'package:flutter_template/util/const.dart';

/// Утилиты для форматирования времени
class TimeFormatter {
  /// форматирует [TimeDuration] в строку
  /// прим.: 6 дней 12 часов 30 минут
  static String formatToString(TimeDuration duration) {
    final result = StringBuffer();

    final days = duration.days;
    final hours = duration.hours;
    final minutes = duration.minutes;

    if (days != 0) {
      result..write(daysText(days))..write(space);
    }

    if (hours != 0) {
      result..write(hoursText(hours))..write(space);
    }

    if (minutes != 0 || duration.inMinutes == 0) {
      result..write(minutesText(minutes))..write(space);
    }

    return result.toString().trim();
  }
}
