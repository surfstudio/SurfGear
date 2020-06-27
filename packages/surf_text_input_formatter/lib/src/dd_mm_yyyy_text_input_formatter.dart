import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/parser.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for the text field
/// Formats the entered string with numbers in
/// Date in the form of DD.MM.YYYY
class DdMmYyyyTextInputFormatter extends SeparateTextInputFormatter {
  final int _dayEndLastCount = 2;
  final int _monthEndLastCount = 4;
  final int _maxDayValue = 31;
  final int _maxMonthValue = 12;

  DdMmYyyyTextInputFormatter()
      : super(
          separatorPositions: [2, 5],
          separateSymbols: ['.'],
          maxLength: 10,
          type: SeparateTextInputFormatterType.number,
        );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (isManualRemove(oldValue, newValue)) return newValue;

    final String newRawText = onlyNeedSymbols(newValue.text);

    final int count = newRawText.length;

    try {
      if (count >= _dayEndLastCount &&
          parseInt(newRawText.substring(0, 2)) > _maxDayValue) {
        return oldValue;
      }

      if (count >= _monthEndLastCount &&
          parseInt(newRawText.substring(2, 4)) > _maxMonthValue) {
        return oldValue;
      }
    } catch (e) {
      return oldValue;
    }

    return super.formatEditUpdate(oldValue, newValue);
  }
}
