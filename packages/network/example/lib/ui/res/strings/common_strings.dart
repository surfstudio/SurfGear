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

import 'package:intl/intl.dart';
import 'package:name_generator/util/const.dart';

const String nextButtonText = "Готово";
const String okText = "ОК";
const String cancelText = "ОТМЕНА";
const String itemNotFoundException = "Товар не найден";

const String userNotFoundText = "Пользователь не найден";

//placeholder
const String errorPlaceholderTitleText = "Данные недоступны";
const String errorPlaceholderSubtitleText = "Попробуйте повторить позже";
const String errorPlaceholderBtnText = "Обновить";

//ошибки сети
const serverErrorMessage =
    "Нет ответа от сервера, попробуйте еще раз или зайдите позже";
const serverErrorNotFound =
    "Произошла ошибка, данные не найдены. Попробуйте позже еще раз";
const defaultHttpErrorMessage =
    "Произошла ошибка, данные не найдены. Попробуйте позже еще раз";
const forbiddenErrorMessage = "Доступ запрещен";
const noInternetConnectionErrorMessage =
    "Нет соединения с интернетом, проверьте подключение";
const badResponseErrorMessage =
    "Произошла ошибка загрузки данных на экране. Попробуйте позже еще раз";
const unexpectedErrorMessage = "Непредвиденная ошибка";
const commonErrorText = "Произошла ошибка. Попробуйте позже";

//region time formatter
String daysText(int days) => "$days ${dayPlural(days)}";

String hoursText(int hours) => "$hours ${hourPlural(hours)}";

String minutesText(int minutes) => "$minutes ${minutesPlural(minutes)}";

String dayPlural(int days) => Intl.plural(
      days,
      zero: EMPTY_STRING,
      one: "день",
      two: "дня",
      few: "дней",
      other: "дней",
      many: "дней",
    );

String hourPlural(int hours) => Intl.plural(
      hours,
      zero: EMPTY_STRING,
      one: "час",
      two: "часа",
      few: "часов",
      other: "часа",
      many: "часов",
    );

String minutesPlural(int minutes) => Intl.plural(
      minutes,
      zero: "минут",
      one: "минута",
      two: "минуты",
      few: "минут",
      other: "минут",
      many: "минут",
    );
//endregion
