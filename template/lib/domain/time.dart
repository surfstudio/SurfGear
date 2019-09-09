/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter_template/util/const.dart';

/// Обёртка над Duration для вычисления кол-ва дней, часов, минут и т.д.
///
/// особенности:
/// - 100 сек => 1 минута 40 сек
/// - 30 часов => 1 день 6 часов
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
