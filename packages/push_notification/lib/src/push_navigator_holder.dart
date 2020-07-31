import 'package:flutter/widgets.dart';

/// global navigator context storage
class PushNavigatorHolder {
  factory PushNavigatorHolder() => _instance;

  PushNavigatorHolder._internal();

  NavigatorState navigator;

  static final PushNavigatorHolder _instance = PushNavigatorHolder._internal();

  static PushNavigatorHolder get instance => _instance;
}
