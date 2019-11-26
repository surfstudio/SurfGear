import 'package:flutter/cupertino.dart';

/// global singleton context holder
class GlobalContextHolder {
  static final GlobalContextHolder _instance = GlobalContextHolder._();

  BuildContext context;

  factory GlobalContextHolder() => _instance;

  GlobalContextHolder._();
}
