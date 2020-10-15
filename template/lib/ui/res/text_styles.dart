import 'package:flutter/painting.dart';
import 'package:flutter_template/ui/res/colors.dart';

/// Стили текстов

TextStyle _text = const TextStyle(
  fontStyle: FontStyle.normal,
  color: textColorPrimary,
),

//Light
    textLight = _text.copyWith(fontWeight: FontWeight.w300),

//Regular
    textRegular = _text.copyWith(fontWeight: FontWeight.normal),
    textRegular16 = textRegular.copyWith(fontSize: 16.0),
    textRegular16Secondary = textRegular16.copyWith(color: textColorSecondary),
    textRegular16Grey = textRegular16.copyWith(color: textColorGrey),

//Medium
    textMedium = _text.copyWith(fontWeight: FontWeight.w500),
    textMedium20 = textMedium.copyWith(fontSize: 20.0),
//Bold
    textBold = _text.copyWith(fontWeight: FontWeight.bold);
