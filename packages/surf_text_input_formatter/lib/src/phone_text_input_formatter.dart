import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

/// [TextInputFormatter] for Phone
class PhoneTextInputFormatter extends SeparateTextInputFormatter {
  PhoneTextInputFormatter(String countryCode, {bool isFormatAfterEnter})
      : super.fromSchema(
          '(###) ### ## ##',
          maxLength: 18,
          type: SeparateTextInputFormatterType.number,
          isFormatAfterEnter: isFormatAfterEnter,
          fixedPrefix: countryCode + ' ',
        );
}
