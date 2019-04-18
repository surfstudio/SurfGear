import 'dart:ui';

import 'package:flutter/material.dart';

///Базовый класс контроллера отображения диалогов
abstract class DialogController {

  void showAlertDialog({
    String title,
    String message,
    VoidCallback onAgreeClicked,
    VoidCallback onDisagreeClicked,
  });
}
