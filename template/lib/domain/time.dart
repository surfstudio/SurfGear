import 'package:flutter_template/util/const.dart';

///
class TimeDuration {
  Duration _innerDuration;

  TimeDuration(this._innerDuration);

  TimeDuration.fromSeconds(int seconds) : this(Duration(seconds: seconds));

  ///период в минутах
  int get inMinutes => _innerDuration.inMinutes;

  ///период в секунднах
  int get inSeconds => _innerDuration.inSeconds;

  ///кол-во дней
  int get days => _innerDuration.inDays;

  ///кол-во часов
  int get hours =>
      _innerDuration.inHours - (_innerDuration.inDays * HOURS_IN_DAY);

  ///кол-во минут
  int get minutes =>
      _innerDuration.inMinutes - (_innerDuration.inHours * MINUTES_IN_HOUR);

  ///кол-во секунд
  int get seconds =>
      _innerDuration.inSeconds - (_innerDuration.inMinutes * SECONDS_IN_MINUTE);

  ///увеличение периода на 1 минуту
  void incrementMinute() {
    var newMinutes = _innerDuration.inMinutes;
    _innerDuration = Duration(minutes: ++newMinutes);
  }

  ///уменьшение периода на 1 минуту
  void decrementMinute() {
    var newMinutes = _innerDuration.inMinutes;
    _innerDuration = Duration(minutes: --newMinutes);
  }
}
