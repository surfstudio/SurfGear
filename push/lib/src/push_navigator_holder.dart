import 'package:flutter/widgets.dart';

class PushNavigatorHolder {
  NavigatorState navigator;

  static final PushNavigatorHolder _instance = PushNavigatorHolder._internal();

  factory PushNavigatorHolder() => _instance;

  PushNavigatorHolder._internal();
}
