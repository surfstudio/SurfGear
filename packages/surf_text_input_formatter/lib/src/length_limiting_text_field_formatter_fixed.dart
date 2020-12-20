import 'package:flutter/services.dart';

///Fixed LengthLimitingTextInputFormatter.
/// Idea taken from issue:
///https://github.com/flutter/flutter/issues/67236
class LengthLimitingTextFieldFormatterFixed
    extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed(int maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength == null ||
        maxLength <= 0 ||
        newValue.text.characters.length <= maxLength) {
      return newValue;
    }
    if (oldValue.text.characters.length == maxLength) {
      return oldValue;
    }
    return LengthLimitingTextInputFormatter.truncate(newValue, maxLength);
  }
}
