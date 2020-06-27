import 'package:surf_text_input_formatter/src/separate_text_input_formatter.dart';
import 'package:surf_text_input_formatter/src/separate_text_input_formatter_type.dart';

class PaymentCardTextInputFormatter extends SeparateTextInputFormatter {
  PaymentCardTextInputFormatter()
      : super(
          step: 4,
          stepSymbol: ' ',
          maxLength: 19,
          type: SeparateTextInputFormatterType.number,
        );
}
