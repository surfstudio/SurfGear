import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';

/// [TextInputFormatter] for email
class EmailTextInputFormatter extends SeparateTextInputFormatter {
  /// Allowed characters for use in email
  static final _regExpAllowedCharacters = RegExp(
      r"[a-zA-Z]|\d|@|\.|!|%|&|'|\+|-|/|=|\^|_|`|\{|\}|~|\*|\?|\(|\)|\$");

  EmailTextInputFormatter({
    bool isFormatBeforeEnterNextSymbol,
    int maxLength,
  }) : super(
          maxLength: maxLength ?? 256,
          symbolRegExp: _regExpAllowedCharacters,
          isFormatBeforeEnterNextSymbol: isFormatBeforeEnterNextSymbol,
        );
}
