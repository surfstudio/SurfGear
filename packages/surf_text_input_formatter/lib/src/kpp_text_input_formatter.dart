import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for KPP
class KppTextInputFormatter extends SeparateTextInputFormatter {
  KppTextInputFormatter()
      : super(
          maxLength: 9,
          type: SeparateTextInputFormatterType.number,
        );
}
