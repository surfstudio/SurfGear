import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] with custom parameters
class SeparateTextInputFormatter extends TextInputFormatter {
  static const EMPTY_STRING = '';
  static const _schemaSymbol = '#';

  /// Positions for delimiters
  List<int> separatorPositions;

  /// Separator characters
  /// Match [separatorPositions]
  /// If [separatorPositions] is less
  /// - the last separator from the list will be used
  ///
  /// [separatorPositions] and [separateSymbols]
  /// depends on the separator characters. #.# - when setting the separator,
  /// you need to write position 1.
  ///
  /// separatorPositions: [1, 3, 5],
  /// separateSymbols: ['-', '.', ','],
  /// result:
  /// #-#.#,#
  ///
  /// separatorPositions: [1, 3, 5],
  /// separateSymbols: ['-', '.'],
  /// result:
  /// #-#.#.#
  List<String> separateSymbols;

  /// Space position step, if you need to paste them evenly
  /// Complements [separateSymbols]
  ///
  /// [step] and [stepSymbol] ignore [separateSymbols]
  /// and take position only from the entered text
  ///
  /// separatorPositions: [1, 3, 5, 10],
  /// separateSymbols: ['-', '.', ','],
  /// step: 5,
  /// stepSymbol: '//',
  /// result:
  /// '#-#.#,##//##,###//#####
  ///
  /// step to insert [stepSymbol]
  final int step;

  ///Separator inserted at intervals equal to [step]
  final String stepSymbol;

  /// Regular expression characters to include
  final RegExp symbolRegExp;

  /// Used when [symbolRegExp] is not passed.
  final SeparateTextInputFormatterType type;
  final bool isFormatBeforeEnterNextSymbol;

  final int maxLength;

  /// A character string that cannot be removed
  final String fixedPrefix;
  final int _prefixLength;

  bool get _isSeparators => (separatorPositions?.length ?? 0) > 0;

  @protected
  RegExp get symbolRegExpValue {
    return symbolRegExp ?? type.value;
  }

  bool get _isExistPrefix => fixedPrefix != null;

  SeparateTextInputFormatter({
    this.step,
    this.separateSymbols,
    this.symbolRegExp,
    this.type,
    this.fixedPrefix,
    int maxLength,
    bool isFormatBeforeEnterNextSymbol,
    String stepSymbol,
    List<int> separatorPositions,
  })  : stepSymbol = stepSymbol ?? '',
        isFormatBeforeEnterNextSymbol = isFormatBeforeEnterNextSymbol ?? false,
        _prefixLength = fixedPrefix?.length ?? 0,
        maxLength = fixedPrefix == null
            ? maxLength
            : maxLength - fixedPrefix?.length ?? 0,
        assert(symbolRegExp != null || type != null) {
    if (separatorPositions != null) {
      this.separatorPositions = [...separatorPositions]..sort();
    }
  }

  /// Separation according to the schema
  SeparateTextInputFormatter.fromSchema(
    String schema, {
    this.symbolRegExp,
    this.type,
    this.fixedPrefix,
    int maxLength,
    bool isFormatBeforeEnterNextSymbol,
  })  : step = null,
        stepSymbol = null,
        isFormatBeforeEnterNextSymbol = isFormatBeforeEnterNextSymbol ?? false,
        _prefixLength = fixedPrefix?.length ?? 0,
        maxLength = fixedPrefix == null
            ? maxLength
            : maxLength - fixedPrefix?.length ?? 0 {
    assert(schema != null);

    final int schemaLength = schema.length;

    separatorPositions = [];
    separateSymbols = [];

    for (int i = 0; i < schemaLength; i++) {
      if (schema[i] == _schemaSymbol) continue;
      separatorPositions.add(i);
      separateSymbols.add(schema[i]);
    }
  }

  String _getSeparator(int index) {
    if (separateSymbols?.isEmpty ?? false) return '';
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
    if (isManualRemove(oldValue, newValue)) {
      if (_checkIsExistPrefix(oldValue, newValue)) return newValue;

      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(
          offset: oldValue.text.length,
        ),
      );
    }
    final String newText = getTextWithoutPrefix(newValue.text);
    final String newRawText = getOnlyNeedSymbols(newText);
    final int newTextLength = newRawText.length;
    final int separatorPosCount = separatorPositions?.length ?? 0;
    final StringBuffer buffer = StringBuffer();

    try {
      int rawOffset = _getRawOffset(newValue, newText);

      int calculateOffset = isFormatBeforeEnterNextSymbol
          ? _formatBefore(
              newTextLength: newTextLength,
              newRawText: newRawText,
              rawOffset: rawOffset,
              buffer: buffer,
              separatorPosCount: separatorPosCount,
            )
          : _formatAfter(
              newTextLength: newTextLength,
              newRawText: newRawText,
              rawOffset: rawOffset,
              buffer: buffer,
              separatorPosCount: separatorPosCount,
            );

      String result = buffer.toString();

      if (maxLength != null) {
        if (result.length > maxLength) result = result.substring(0, maxLength);
        result = result.substring(0, min(result.length, maxLength));
      }
      calculateOffset =
          rawOffset == result.length ? rawOffset : calculateOffset;

      if (_isExistPrefix) {
        result = fixedPrefix + result;
        calculateOffset += _prefixLength;
      }

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

  @protected
  String getTextWithoutPrefix(String text) {
    if (!_isExistPrefix) return text;
    return text.replaceFirst(fixedPrefix, EMPTY_STRING);
  }

  /// Delete everything except regExp
  @protected
  String getOnlyNeedSymbols(String text) {
    StringBuffer buffer = StringBuffer();
    for(int i = 0; i < text.length; i++) {
      if(!symbolRegExpValue.hasMatch(text[i])) continue;
      buffer.write(text[i]);
    }

    return buffer.toString();
  }

  /// Check for character-by-character manual deletion
  @protected
  bool isManualRemove(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = getOnlyNeedSymbols(newValue.text).length;

    return (oldValue.text.length > 0 &&
            newValue.text.length == oldValue.text.length - 1) &&
        newTextLength ==
            getOnlyNeedSymbols(oldValue.text)
                .substring(0, newTextLength)
                .length;
  }

  /// Option with an insert before entering next a character
  int _formatBefore({
    @required int newTextLength,
    @required String newRawText,
    @required int rawOffset,
    @required StringBuffer buffer,
    @required int separatorPosCount,
  }) {
    int calculateOffset = rawOffset;
    int separatorIndex = 0;

    for (int i = 0; i < newTextLength; i++) {
      calculateOffset = _insertStepSymbol(
        i,
        step,
        calculateOffset,
        rawOffset,
        buffer,
      );

      if (_isSeparators && separatorIndex < separatorPosCount) {
        /// The nested loop is needed to display more than one separator
        /// of the following one after another
        /// #.#.#..#
        for (int j = separatorIndex; j < separatorPosCount; j++) {
          if (i + separatorIndex != separatorPositions[j]) continue;
          buffer.write(_getSeparator(j));
          separatorIndex++;
          calculateOffset = _updateOffset(
            calculateOffset: calculateOffset,
            rawOffset: rawOffset,
            index: i,
            symbol: _getSeparator(j),
          );
        }
      }
      buffer.write(newRawText[i]);
    }
    return calculateOffset;
  }

  /// Option with an insert after entering current a character
  int _formatAfter({
    @required int newTextLength,
    @required String newRawText,
    @required int rawOffset,
    @required StringBuffer buffer,
    @required int separatorPosCount,
  }) {
    int calculateOffset = rawOffset;
    int separatorIndex = 0;
    final bool isFirstZeroIndex =
        separatorPositions != null && separatorPositions[0] == 0;

    /// Option with insertion after entering a character
    for (int i = 0; i < newTextLength; i++) {
      if (separatorIndex < separatorPosCount &&
          i + separatorIndex == 0 &&
          isFirstZeroIndex) {
        buffer.write(_getSeparator(0));

        separatorIndex++;
        calculateOffset = _updateOffset(
          calculateOffset: calculateOffset,
          rawOffset: rawOffset,
          index: i,
          symbol: _getSeparator(0),
        );
      }

      buffer.write(newRawText[i]);

      calculateOffset = _insertStepSymbol(
        i,
        step,
        calculateOffset,
        rawOffset,
        buffer,
      );

      if (_isSeparators && separatorIndex < separatorPosCount) {
        for (int j = separatorIndex; j < separatorPosCount; j++) {
          if (i == 0 && isFirstZeroIndex ||
              i + separatorIndex + 1 != separatorPositions[j]) continue;
          buffer.write(_getSeparator(j));
          separatorIndex++;
          calculateOffset = _updateOffset(
            calculateOffset: calculateOffset,
            rawOffset: rawOffset,
            index: i,
            symbol: _getSeparator(j),
          );
        }
      }
    }
    return calculateOffset;
  }

  int _updateOffset({
    @required int calculateOffset,
    @required int rawOffset,
    @required int index,
    @required String symbol,
  }) {
    if (index < rawOffset) {
      return calculateOffset + symbol.length;
    }
    return calculateOffset;
  }

  int _insertStepSymbol(
    int index,
    int step,
    int calculateOffset,
    int rawOffset,
    buffer,
  ) {
    final int stepPosition = isFormatBeforeEnterNextSymbol ? index : index + 1;

    if (step != null && index > 0 && stepPosition % step == 0) {
      buffer.write(stepSymbol);
      calculateOffset = _updateOffset(
        calculateOffset: calculateOffset,
        rawOffset: rawOffset,
        index: index,
        symbol: stepSymbol,
      );
    }
    return calculateOffset;
  }

  int _getRawOffset(TextEditingValue value, String text) {
    int offset = _isExistPrefix && value.text.contains(fixedPrefix)
        ? value.selection.baseOffset - _prefixLength
        : value.selection.baseOffset;

    int rawOffset = getOnlyNeedSymbols(
      text.substring(0, offset),
    ).length;
    return rawOffset;
  }

  bool _checkIsExistPrefix(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!_isExistPrefix) return true;
    return oldValue.text.contains(fixedPrefix) &&
        newValue.text.contains(fixedPrefix);
  }
}
