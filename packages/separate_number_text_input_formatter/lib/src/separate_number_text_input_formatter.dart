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
    if (separateSymbols == null) return '';
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
    final int separatorPosCount = separatorPositions.length;
    final StringBuffer buffer = StringBuffer();

    int rawOffset = _onlyNumbers(
      newValue.text.substring(0, newValue.selection.baseOffset),
    ).length;

    int calculateOffset = rawOffset;

    int separatorIndex = 0;

    try {
      for (int i = 0; i < newTextLength; i++) {
        if (step != null && i > 0 && i % step == 0) {
          buffer.write(stepSymbol);
          if(i < rawOffset) calculateOffset++;
        }
        buffer.write(newText[i]);
        if (_isSeparators && separatorIndex < separatorPosCount) {
          for (int j = separatorIndex; j < separatorPosCount; j++) {
            if (i + separatorIndex != separatorPositions[j] - 1) continue;
            buffer.write(_getSeparator(j));
            separatorIndex++;
            if(i < rawOffset) calculateOffset++;
          }
        }
      }
      String result = buffer.toString();

      if (maxLength != null) {
        if (result.length == maxLength) result.trim();
        result = result.substring(0, min(result.length, maxLength));
      }
      //print('!!! $baseOffset => ${result.length}');
      calculateOffset =
          rawOffset == result.length ? rawOffset : calculateOffset;
      return TextEditingValue(
        text: result,
        selection: TextSelection.collapsed(
          offset: min(calculateOffset, result.length),
        ),
      );
    } catch (e) {
      return oldValue;
    }
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
