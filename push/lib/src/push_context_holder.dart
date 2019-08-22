import 'package:flutter/widgets.dart';

class PushContextHolder {

  BuildContext context;

  static final PushContextHolder _singleton = new PushContextHolder._internal();

  factory PushContextHolder() {
    return _singleton;
  }

  PushContextHolder._internal();
}
