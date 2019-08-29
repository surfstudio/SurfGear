import 'package:flutter/widgets.dart';

/// global navigator context storage
class PushNavigatorHolder {
  NavigatorState navigator;

  static final PushNavigatorHolder _instance = PushNavigatorHolder._internal();

  factory PushNavigatorHolder() => _instance;

  static PushNavigatorHolder get instance => _instance;

  PushNavigatorHolder._internal();
}
