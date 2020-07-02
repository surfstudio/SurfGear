import 'package:flutter/services.dart';

/// Копипаст с либы
class MaskTextInputFormatter extends TextInputFormatter {
  Map<int, String> _maskMap;
  List<int> _maskList;

  MaskTextInputFormatter(String maskString, {escapeChar = '_'}) {
    assert(maskString != null);
    final entries = RegExp('[^$escapeChar]+')
        .allMatches(maskString)
        .map((match) => MapEntry<int, String>(match.start, match.group(0)));

    _maskMap = Map.fromEntries(entries);
    _maskList = _maskMap.keys.toList();
  }

  String getEscapedString(String inputText) {
    String escapedString;
    _maskList.reversed
        .where((index) =>
            index < inputText.length && _substringIsMask(inputText, index))
        .forEach(
      (index) {
        escapedString = inputText.substring(0, index) +
            inputText.substring(index + _maskMap[index].length);
      },
    );
    return escapedString;
  }

  bool _substringIsMask(String inputText, int index) {
    return inputText.substring(index, index + _maskMap[index].length) ==
        _maskMap[index];
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var escapedString = getEscapedString(newValue.text);
    var position = newValue.selection.baseOffset -
        (newValue.text.length - escapedString.length);

    for (int index in _maskList) {
      if (escapedString.length > index) {
        escapedString = escapedString.substring(0, index) +
            _maskMap[index] +
            escapedString.substring(index);
        position += _maskMap[index].length;
      }
    }

    return newValue.copyWith(
        text: escapedString,
        selection: TextSelection.collapsed(offset: position));
  }
}
