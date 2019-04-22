import 'dart:ui';

///Базовый класс контроллера отображения диалогов
abstract class DialogController {
  void showAlertDialog({
    String title,
    String message,
    VoidCallback onAgreeClicked,
    VoidCallback onDisagreeClicked,
  });
}
