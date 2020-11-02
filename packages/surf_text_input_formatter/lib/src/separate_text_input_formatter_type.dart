import 'package:flutter/services.dart';

final _numberRegExp = RegExp(r"\d");

/// Character types for [TextInputFormatter]
enum SeparateTextInputFormatterType {
  number,
}

extension SeparateTextInputFormatterTypeValue
    on SeparateTextInputFormatterType {
  RegExp get value {
    switch (this) {
      case SeparateTextInputFormatterType.number:
        return _numberRegExp;
    }
    return null;
  }
}
