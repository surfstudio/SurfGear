import 'package:flutter/widgets.dart';

/// BuildContext global storage
class BuildContextHolder {
  BuildContext context;

  static final BuildContextHolder _instance = BuildContextHolder._internal();

  static BuildContextHolder get instance => _instance;

  factory BuildContextHolder() => _instance;

  BuildContextHolder._internal();
}
