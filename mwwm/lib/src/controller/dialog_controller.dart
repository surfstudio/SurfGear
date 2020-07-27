import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum PickDateMode { day, month, year }

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
    PickDateMode initialDatePickerMode = PickDateMode.day,
    Locale locale,
    TextDirection textDirection,
    TransitionBuilder builder,
  });

  Future showLoading();

  void dismiss();
}
