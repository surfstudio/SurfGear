import 'package:flutter/services.dart';

final _noNumberRegExp = RegExp(r"\D");

/// Character types for [TextInputFormatter]
enum SeparateTextInputFormatterType {
  number,
  word,
}

extension SeparateTextInputFormatterTypeValue
    on SeparateTextInputFormatterType {
  RegExp get value {
    switch (this) {
      case SeparateTextInputFormatterType.number:
        return _noNumberRegExp;
    }
    return null;
  }
}
