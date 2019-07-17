import 'package:flutter/widgets.dart' as widgets;

import 'package:mwwm/src/event/action.dart';

/// Action for text editing
class TextEditingAction extends Action<String> {
  final widgets.TextEditingController controller =
      _ExtendedTextEditingController();

  TextEditingAction([void Function(String data) onChanged]) : super(onChanged) {
    controller.addListener(() {
      accept(controller.value.text);
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// При обновлении текста через сеттер переводит курсор на конец строки
class _ExtendedTextEditingController extends widgets.TextEditingController {
  _ExtendedTextEditingController({String text}) : super(text: text);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: widgets.TextSelection.collapsed(offset: newText.length),
      composing: widgets.TextRange.empty,
    );
  }
}
