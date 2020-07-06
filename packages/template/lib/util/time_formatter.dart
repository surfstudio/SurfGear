import 'package:flutter_template/domain/time.dart';
import 'package:flutter_template/ui/res/strings/common_strings.dart';
import 'package:flutter_template/util/const.dart';

/// Утилиты для форматирования времени
class TimeFormatter {
  /// форматирует [TimeDuration] в строку
  /// прим.: 6 дней 12 часов 30 минут
  static String formatToString(TimeDuration duration) {
    var result = StringBuffer();

    final days = duration.days;
    final hours = duration.hours;
    final minutes = duration.minutes;

    if (days != 0) {
      result.write(daysText(days));
      result.write(space);
    }

    if (hours != 0) {
      result.write(hoursText(hours));
      result.write(space);
    }

    if (minutes != 0 || duration.inMinutes == 0) {
      result.write(minutesText(minutes));
      result.write(space);
    }

    return result.toString().trim();
  }
}
