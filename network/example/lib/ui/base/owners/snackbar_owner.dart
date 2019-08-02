import 'package:flutter/material.dart';

/// Сущность, содержащая информацию о  кастомных снеках(отличающихся от стандартных в приложении)
/// Для использования функционала необходимо подмешать к виджету и
/// определить геттер с вилом снеков по типу
mixin CustomSnackBarOwner {
  Map<dynamic, SnackBar Function(String)> get registeredSnackBarsBuilder;
}
