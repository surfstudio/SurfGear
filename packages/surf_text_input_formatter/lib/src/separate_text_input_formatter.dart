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
  final int step;
  final String stepSymbol;
  final RegExp excludeRegExp;
  final SeparateTextInputFormatterType type;
  final bool isAfterFormat;

  final int maxLength;

  final String fixedPrefix;
  final int _prefixLength;

  bool get _isSeparators => (separatorPositions?.length ?? 0) > 0;

  @protected
  RegExp get excludeRegExpValue {
    return excludeRegExp ?? type.value;
  }

  bool get _isExistPrefix => fixedPrefix != null;

  SeparateTextInputFormatter({
    List<int> separatorPositions,
    this.step,
    String stepSymbol,
    this.separateSymbols,
    this.maxLength,
    this.excludeRegExp,
    this.type,
    bool isAfterFormat,
    this.fixedPrefix,
  })  : stepSymbol = stepSymbol ?? '',
        isAfterFormat = isAfterFormat ?? false,
        _prefixLength = fixedPrefix?.length ?? 0,
        assert(excludeRegExp != null || type != null) {
    if (separatorPositions != null) {
      this.separatorPositions = [...separatorPositions]..sort();
    }
  }

  /// Separation according to the schema
  SeparateTextInputFormatter.fromSchema(
    String schema, {
    this.maxLength,
    this.excludeRegExp,
    this.type,
    bool isAfterFormat,
    this.fixedPrefix,
  })  : step = null,
        stepSymbol = null,
        isAfterFormat = isAfterFormat ?? false,
        _prefixLength = fixedPrefix?.length ?? 0 {
    assert(schema != null);

    final schemaLength = schema.length;

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
      if (_isExistPrefix && oldValue.text == fixedPrefix) {
        return TextEditingValue(
          text: fixedPrefix,
          selection: TextSelection.collapsed(
            offset: _prefixLength,
          ),
        );
      }
      return newValue;
    }
    final String newText = getTextWithoutPrefix(newValue.text);
    final String newRawText = getOnlyNeedSymbols(newText);
    final int newTextLength = newRawText.length;
    final int separatorPosCount = separatorPositions?.length ?? 0;
    final StringBuffer buffer = StringBuffer();

    try {
      int rawOffset = _getRawOffset(newValue, newText);

      int calculateOffset = isAfterFormat
          ? _formatAfter(
              newTextLength: newTextLength,
              newRawText: newRawText,
              rawOffset: rawOffset,
              buffer: buffer,
              separatorPosCount: separatorPosCount,
            )
          : _formatBefore(
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

  int _formatBefore({
    @required int newTextLength,
    @required String newRawText,
    @required int rawOffset,
    @required StringBuffer buffer,
    @required int separatorPosCount,
  }) {
    int calculateOffset = rawOffset;
    int separatorIndex = 0;

    /// Option with an insert before entering a character
    for (int i = 0; i < newTextLength; i++) {
      if (step != null && i > 0 && i % step == 0) {
        buffer.write(stepSymbol);
        calculateOffset = _updateOffset(
          calculateOffset: calculateOffset,
          rawOffset: rawOffset,
          index: i,
          symbol: stepSymbol,
        );
      }

      if (_isSeparators && separatorIndex < separatorPosCount) {
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

  int _formatAfter({
    @required int newTextLength,
    @required String newRawText,
    @required int rawOffset,
    @required StringBuffer buffer,
    @required int separatorPosCount,
  }) {
    int calculateOffset = rawOffset;
    int separatorIndex = 0;

    /// Option with insertion after entering a character
    for (int i = 0; i < newTextLength; i++) {
      buffer.write(newRawText[i]);
      if (step != null && i > 0 && (i + 1) % step == 0) {
        buffer.write(stepSymbol);
        calculateOffset = _updateOffset(
          calculateOffset: calculateOffset,
          rawOffset: rawOffset,
          index: i,
          symbol: stepSymbol,
        );
      }

      if (_isSeparators && separatorIndex < separatorPosCount) {
        for (int j = separatorIndex; j < separatorPosCount; j++) {
          if (i + separatorIndex != separatorPositions[j] - 1) continue;
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

  @protected
  String getTextWithoutPrefix(String text) {
    if (!_isExistPrefix) return text;
    return text.replaceFirst(fixedPrefix, EMPTY_STRING);
  }

  /// Delete everything except regExp
  @protected
  String getOnlyNeedSymbols(String text) {
    if (excludeRegExpValue == null) return text;

    return text.replaceAll(excludeRegExpValue, EMPTY_STRING);
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

  _getRawOffset(TextEditingValue value, String text) {
    int offset = _isExistPrefix && value.text.contains(fixedPrefix)
        ? value.selection.baseOffset - _prefixLength
        : value.selection.baseOffset;

    int rawOffset = getOnlyNeedSymbols(
      text.substring(0, offset),
    ).length;
    return rawOffset;
  }
}
