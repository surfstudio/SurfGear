import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for Phone
class PhoneTextInputFormatter extends SeparateTextInputFormatter {
  PhoneTextInputFormatter(String countryCode,
      {bool isFormatBeforeEnterNextSymbol})
      : super.fromSchema(
          '(###) ### ## ##',
          maxLength: 16 + countryCode.length,
          type: SeparateTextInputFormatterType.number,
          isFormatBeforeEnterNextSymbol: isFormatBeforeEnterNextSymbol,
          fixedPrefix: countryCode + ' ',
        );
}
