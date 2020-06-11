import 'package:mwwm/mwwm.dart';

/// Log errors
class DefaultErrorHadler implements ErrorHandler {
  @override
  void handleError(Object e) {
    //here you can place logic for error handling
    print(e);
  }
}
