import 'dart:ui';

abstract class MessageController {
  void showSnack(String msg);

  void showAlertDialog({
    String title,
    String message,
    VoidCallback onAgreeClicked,
    VoidCallback onDisagreeClicked,
  });
}
