import 'package:flutter_template/domain/time.dart';
import 'package:flutter_template/ui/res/strings/common_strings.dart';
import 'package:flutter_template/util/const.dart';

class TimeFormatter {
  static String formatToString(TimeDuration duration) {
    var result = StringBuffer();

    final days = duration.days;
    final hours = duration.hours;
    final minutes = duration.minutes;

    if (days != 0) {
      result.write(daysText(days));
      result.write(SPACE);
    }

    if (hours != 0) {
      result.write(hoursText(hours));
      result.write(SPACE);
    }

    if (minutes != 0 || duration.inMinutes == 0) {
      result.write(minutesText(minutes));
      result.write(SPACE);
    }

    return result.toString().trim();
  }
}
