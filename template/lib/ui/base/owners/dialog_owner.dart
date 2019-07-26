import 'package:flutter/widgets.dart';

/// Миксин, добавляющий возможност зарегистрировать диалоги
mixin DialogOwner {
  Map<dynamic, WidgetBuilder> get registeredDialogs;
}