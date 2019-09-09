import 'package:flutter/widgets.dart';

mixin DialogOwner {
  Map<dynamic, WidgetBuilder> get registeredDialogs;
}
