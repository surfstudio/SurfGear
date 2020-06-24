import 'dart:math';

import 'package:flutter/services.dart';

class SpacesTextInputFormatter extends TextInputFormatter {
  static final _noNumberRegExp = RegExp(r"\D");
  static const _EMPTY_STRING = '';

  /// Позиции для пробелов
  List<int> separatorPositions;

  /// Шаг позици пробелов, если нужно их равномерно вставить
  final int step;

  final String stepSymbol;

  /// Символы разделители
  /// Соответствуют [separatorPositions]
  /// Если [separatorPositions] меньше
  /// - будет использоваться последний разделитель из списка
  List<String> separateSymbols;

  final int maxLength;

  bool get _isSeparators => separatorPositions?.length != null;

  SpacesTextInputFormatter({
    List<int> separatorPositions,
    this.step,
    String stepSymbol,
    this.separateSymbols,
    this.maxLength,
  }) : stepSymbol = stepSymbol ?? '' {
    if (separatorPositions != null) {
      this.separatorPositions = [...separatorPositions]..sort();
    }
  }

  String _getSeparator(int index) {
    if(separateSymbols == null) return '';
    if (index >= separateSymbols.length) {
      return separateSymbols[separateSymbols.length - 1];
    }
    return separateSymbols[index];
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (isManualRemove(oldValue, newValue)) return newValue;

    final String newText = _onlyNumbers(newValue.text);

    final int newTextLength = newText.length;

    int separatorIndex = 0;

    StringBuffer buffer = StringBuffer();

    int baseOffset = newValue.selection.baseOffset;
    int calcBaseOffset = baseOffset;
    final int separatorPosCount = separatorPositions.length;

    try {
      for (int i = 0; i < newTextLength; i++) {
        if (step != null && i > 0 && i % step == 0) {
          buffer.write(stepSymbol);
          //calcBaseOffset = _calculateBaseOffset(calcBaseOffset, i);
        }
        buffer.write(newText[i]);
        if (_isSeparators && separatorIndex < separatorPosCount) {
          for (int j = separatorIndex; j < separatorPosCount; j++) {
            if(i + separatorIndex != separatorPositions[j]-1) continue;
            buffer.write(_getSeparator(j));
            separatorIndex++;
            //calcBaseOffset = _calculateBaseOffset(calcBaseOffset, i);
          }
        }
      }
      String result = buffer.toString().trim();

      if (maxLength != null) {
        result = result.substring(0, min(result.length, maxLength));
      }

      result = result.trim();
/// Доделать offset
      return TextEditingValue(
        text: result,
        selection: TextSelection.collapsed(offset: result.length),
      );
    } catch (e, s) {
      return oldValue;
    }
  }

  int _calculateBaseOffset(int calcBaseOffset, int index) {
    if(calcBaseOffset >=index) return calcBaseOffset+1;
    return calcBaseOffset;
  }

  /// Удалить все кроме цифр
  String _onlyNumbers(String text) {
    return text.replaceAll(_noNumberRegExp, _EMPTY_STRING);
  }

  /// Проверка на посимвольное ручное удаление
  bool isManualRemove(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = _onlyNumbers(newValue.text).length;

    return (oldValue.text.length > 0 &&
            newValue.text.length == oldValue.text.length - 1) &&
        newTextLength ==
            _onlyNumbers(oldValue.text).substring(0, newTextLength).length;
  }
}
