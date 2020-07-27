import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum DatePickerMode { day, month, year }

///Базовый класс контроллера отображения диалогов
abstract class DialogController {
  Future showAlertDialog({
    String title,
    String message,
    void Function(BuildContext context) onAgreeClicked,
    VoidCallback onDisagreeClicked,
  });

  Future<DateTime> pickDate({
    @required DateTime initialDate,
    @required DateTime firstDate,
    @required DateTime lastDate,
    SelectableDayPredicate selectableDayPredicate,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    Locale locale,
    TextDirection textDirection,
    TransitionBuilder builder,
  });

  Future showLoading();

  void dismiss();
}
