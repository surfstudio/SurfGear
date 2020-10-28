import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] with custom parameters
class SeparateTextInputFormatter extends TextInputFormatter {
  static const EMPTY_STRING = '';

  /// Positions for delimiters
  List<int> separatorPositions;

  /// Separator characters
  /// Match [separatorPositions]
  /// If [separatorPositions] is less
  /// - the last separator from the list will be used
  List<String> separateSymbols;

  /// Space position step, if you need to paste them evenly
  final int step;
  final String stepSymbol;
  final RegExp excludeRegExp;
  final SeparateTextInputFormatterType type;
  final bool isAfterFormat;

  final int maxLength;

  bool get _isSeparators => (separatorPositions?.length ?? 0) > 0;

  @protected
  RegExp get excludeRegExpValue {
    return excludeRegExp ?? type.value;
  }

  SeparateTextInputFormatter({
    List<int> separatorPositions,
    this.step,
    String stepSymbol,
    this.separateSymbols,
    this.maxLength,
    this.excludeRegExp,
    this.type,
    bool isAfterFormat,
  })  : stepSymbol = stepSymbol ?? '',
        isAfterFormat = isAfterFormat ?? false,
        assert(excludeRegExp != null || type != null) {
    if (separatorPositions != null) {
      this.separatorPositions = [...separatorPositions]..sort();
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
    if (isManualRemove(oldValue, newValue)) return newValue;
    final String newText = newValue.text;
    final String newRawText = getOnlyNeedSymbols(newText);
    final int newTextLength = newRawText.length;
    final int separatorPosCount = separatorPositions?.length ?? 0;
    final StringBuffer buffer = StringBuffer();

    int rawOffset = getOnlyNeedSymbols(
      newText.substring(0, newValue.selection.baseOffset),
    ).length;

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
    try {
      String result = buffer.toString();

      if (maxLength != null) {
        if (result.length >= maxLength) result = result.substring(0, maxLength);
        result = result.substring(0, min(result.length, maxLength));
      }
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

  /// Delete everything except regExp
  @protected
  String getOnlyNeedSymbols(String text) {
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
}
