import 'package:flutter/widgets.dart';

///Базовый класс контроллера отображения диалогов
abstract class DialogController {
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    void Function(BuildContext context) onAgreeClicked,
    void Function(BuildContext context) onDisagreeClicked,
  });

  Future<R> showSheet<R>(dynamic type, {VoidCallback onDismiss});

  Future<R> showModalSheet<R>(dynamic type);
}
