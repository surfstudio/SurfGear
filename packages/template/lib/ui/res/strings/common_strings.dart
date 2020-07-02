import 'package:flutter_template/util/const.dart';
import 'package:intl/intl.dart';

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
      zero: emptyString,
      one: "день",
      two: "дня",
      few: "дней",
      other: "дней",
      many: "дней",
    );

String hourPlural(int hours) => Intl.plural(
      hours,
      zero: emptyString,
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
