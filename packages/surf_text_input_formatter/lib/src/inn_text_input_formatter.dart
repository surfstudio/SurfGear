import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for TIN
class InnTextInputFormatter extends SeparateTextInputFormatter {
  InnTextInputFormatter.individual()
      : super(
          maxLength: 12,
          type: SeparateTextInputFormatterType.number,
        );

  InnTextInputFormatter.entity()
      : super(
          maxLength: 10,
          type: SeparateTextInputFormatterType.number,
        );
}
