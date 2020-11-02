import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for TIN
class InnTextInputFormatter extends SeparateTextInputFormatter {
  InnTextInputFormatter.individual({bool isFormatBeforeEnterNextSymbol})
      : super(
          maxLength: 12,
          type: SeparateTextInputFormatterType.number,
          isFormatBeforeEnterNextSymbol: isFormatBeforeEnterNextSymbol,
        );

  InnTextInputFormatter.entity({bool isFormatBeforeEnterNextSymbol})
      : super(
          maxLength: 10,
          type: SeparateTextInputFormatterType.number,
          isFormatBeforeEnterNextSymbol: isFormatBeforeEnterNextSymbol,
        );
}
