import 'package:mwwm/mwwm.dart';

/// Log errors
class DefaultErrorHadler implements ErrorHandler {

  @override
  void handleError(Object e) {
    print(e);
  }
}