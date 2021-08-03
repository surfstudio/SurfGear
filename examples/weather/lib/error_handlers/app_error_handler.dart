import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';

class AppErrorHandler implements ErrorHandler {
  void handleError(Object e) {
    print('------------');
    print(e.toString());
  }
}
