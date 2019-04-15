import 'package:intl/intl.dart';
import 'package:flutter_template/util/const.dart';


String homePageText = 'You have pushed the button this many times:',
    incButtonTooltip = 'Increment';

// Common
const String nextButtonText = "Готово";
const String okText = "ОК";
const String cancelText = "ОТМЕНА";
const String itemNotFoundException = "Товар не найден";
const commonErrorText = "Произошла ошибка. Попробуйте позже";

const String userNotFoundText = "Пользователь не найден";

// Роли
const String cassierRoleName = "Кассир";
const String managerRoleName = "Управляющий магазином";
const String merchendaiserRoleName = "Мерчендайзер";
const String topRoleName = "Топ-менеджер";

//placeholder
const String errorPlaceholderTitleText = "Данные недоступны";
const String errorPlaceholderSubtitleText = "Попробуйте повторить позже";
const String errorPlaceholderBtnText = "Обновить";

// Авторизация
const String phoneInputScreenText =
    "Для авторизации укажите номер\nвашего мобильного телефона",
    phoneInputHintText = "Номер телефона",
    phonePrefix = "+7 ";

//Ввод смс-кода
const String smsInputText = "Введите код из СМС, отправленный\nна номер";
const String smsInputErrorText = "Код введен неверно";
const String smsInputHintText = "Код из СМС";
const String smsResendBtnText = "Отправить код повторно";

//Ввод мак адреса
const String macStepOneTextIos = "Откройте настройки телефона";
const String macStepOneTextAndroid = "Откройте настройки телефона";
const String macStepTwoTextIos = "Выберите пункт \"Основные\"";
const String macStepTwoTextAndroid = "Выберите пункт \"Система\"";
const String macStepThreeTextIos = "Выберите пункт \"Об этом устройстве\"";
const String macStepThreeTextAndroid = "Выберите пункт \"О телефоне\"";
const String macStepFourText =
    "Выберите \"Адрес Wi-Fi\", укажите его\nниже и нажмите кнопку \"Готово\"";

const List<String> macInstructionsIos = [
  macStepOneTextIos,
  macStepTwoTextIos,
  macStepThreeTextIos,
  macStepFourText
];
const List<String> macInstructionsAndroid = [
  macStepOneTextAndroid,
  macStepTwoTextAndroid,
  macStepThreeTextAndroid,
  macStepFourText
];

const String macLabelText = "Адрес Wi-Fi";
const String macHelperText = "Например, 00:С2:13:B3:RR:00";
const String macSkipBtnText = "Пропустить";
const String macTitleText =
    "Для учета рабочего времени укажите мак-адрес вашего устройства";

// Задание пин-кода
const String pinCreateTitleText = "Придумайте код доступа";
const String pinCreateHintText = "Пин-код";
const String pinConfirmHintText = "Повторите пин-код";
const String pinConfirmErrorText = "Код не cовпадает";

// Авторизация через пин-код
const String pinAuthDescriptionText = "Авторизуйтесь, введя код доступа";
const String pinAuthErrorText = "Код введен неверно";
const String pinRestoreBtnText = "Забыл код";

//локальные уведомления
const notificationChannelId = "park_android_channel_id";
const notificationChannelName = "Уведомление";
const notificationDescription = "Парк. Уведомление.";

// Профиль
const profileScreenTitle = "Профиль";
const String profileScreenLogout = "Выход";
const String profilePinChangeText = "Изменить код доступа";
const String profileChangePhoneSuccessMsg = "Номер телефона изменен";
const String profileChangePinSuccessMsg = "Пин-код изменен";
const String profileAlertDialog = "Вы действительно хотите выйти из аккаунта?";

// Изменение номера
const String phoneChangeBtnText = "Изменить";
const String phoneChangeScreenText =
    "Укажите новый номер вашего телефона и \nпройдите этап верификации устройства.";

const String taskDurationText = "Время выполнения";
const String taskTitleText = "Задача";

//сканер ШХ
const barcodeScanTitleText = "Наведите камеру на штрих-код";
const barcodeScanErrorText = "Камера недоступна";

//печать ценников
const printBarcodeBtnText = "Напечатать ценник";

// Изменение пин-кода
const String pinChangeTitle = "Код доступа";
const String pinChangeBtnText = phoneChangeBtnText;
const String pinChangeCurrentHint = "Текущий пин-код";
const String pinChangeNewHint = "Новый пин-код";
const String pinChangeConfirmHint = "Повторите новый пин-код";

// экран задачи
const String taskExecutionTimeText = "Время выполнения";
const String taskCompletionTimeText = "Время до завершения";
const String taskSubtitleText = "Задача";
const String taskStartBtnText = "Начать выполнение";
const String taskContinueBtnText = "Продолжить выполнение";
const String taskEndBtnText = "Завершить и отправить";
const String taskFinishError =
    "Задача завершена"; //todo текс ошибки для завершения задачи

String taskDescriptionText(int count) =>
    "Проверить $count ${taskDescriptionPluralText(count)} товаров";

String taskDescriptionPluralText(int count) => Intl.plural(count,
    zero: EMPTY_STRING,
    one: "наименование",
    two: "наименования",
    few: "наименований",
    other: "наименований",
    many: "наименований");

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

// Список задач
const String activeTaskLabelText = "Выполняется";

// Детали продукта
const String hasNotPriceText = "Ценник остутствует";
const String priceLabelText = "Цена";
const String countLabelText = "Количество";
const String wrongBarcodeErrorText = "Товар не соответствует штрих-коду";
const String doneBtnText = "Готово";

// Сканер ШХ продукта
const checkItemBarcodeBtnText = "Товар отстутствует";
const checkItemBarcodeTipText = "Если товар отсутствует, нажмите на кнопку";

// Главный экран
const String notificationsTabTitle = "Уведомления";
const String tasksTabTitle = "Задачи";
