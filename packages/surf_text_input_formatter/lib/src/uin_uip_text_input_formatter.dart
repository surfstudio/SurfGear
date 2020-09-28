import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for UIN / UIP
class UinUipTextInputFormatter extends SeparateTextInputFormatter {
  UinUipTextInputFormatter()
      : super(
          maxLength: 25,
          type: SeparateTextInputFormatterType.number,
        );

  UinUipTextInputFormatter.min()
      : super(
          maxLength: 20,
          type: SeparateTextInputFormatterType.number,
        );

  factory UinUipTextInputFormatter.max() => UinUipTextInputFormatter();
}
