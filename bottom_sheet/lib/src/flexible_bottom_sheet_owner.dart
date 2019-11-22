import 'package:flutter/widgets.dart';

/// Миксин, добавляющий возможност зарегистрировать Flexible Bottom Sheet
mixin FlexibleBottomSheetOwner {
  Map<dynamic, ScrollableWidgetBuilder> get registeredBottomSheet;
}