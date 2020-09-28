import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for account number
class AccountNumberTextInputFormatter extends SeparateTextInputFormatter {
  AccountNumberTextInputFormatter()
      : super(
          separateSymbols: [' '],
          separatorPositions: [5, 9, 11, 16],
          maxLength: 24,
          type: SeparateTextInputFormatterType.number,
        );
}
