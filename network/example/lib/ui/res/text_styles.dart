/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/painting.dart';
import 'package:name_generator/ui/res/colors.dart';

/// Стили текстов

TextStyle _text = TextStyle(
  fontStyle: FontStyle.normal,
  color: textColorPrimary,
),

//Light
    textLight = _text.copyWith(fontWeight: FontWeight.w300),

//Regular
    textRegular = _text.copyWith(fontWeight: FontWeight.normal),
    textRegular10 = textRegular.copyWith(fontSize: 10.0),
    textRegular10White = textRegular10.copyWith(color: white),
    textRegular12 = textRegular.copyWith(fontSize: 12.0),
    textRegular12Secondary = textRegular12.copyWith(color: textColorSecondary),
    textRegular12Accent = textRegular12.copyWith(color: colorAccent),
    textRegularError = textRegular12.copyWith(color: colorError),
    textRegular14 = textRegular.copyWith(fontSize: 14.0),
    textRegular14Primary = textRegular14.copyWith(color: textColorPrimary),
    textRegular14Secondary = textRegular14.copyWith(color: textColorSecondary),
    textRegular14Red = textRegular14.copyWith(color: textColorRed),
    textRegular14Green = textRegular14.copyWith(color: textColorGreen),
    textRegular16 = textRegular.copyWith(fontSize: 16.0),
    textRegular16Primary = textRegular16.copyWith(color: textColorPrimary),
    textRegular16Secondary = textRegular16.copyWith(color: textColorSecondary),
    textRegular16Grey = textRegular16.copyWith(color: textColorGrey),
    textRegular16White = textRegular16.copyWith(color: white),

//Medium
    textMedium = _text.copyWith(fontWeight: FontWeight.w500),
    textMedium14 = textMedium.copyWith(fontSize: 14.0),
    textMedium14Red = textMedium14.copyWith(color: textColorRed),
    textMedium16 = textMedium.copyWith(fontSize: 16.0),
    textMedium16White = textMedium16.copyWith(color: white),
    textMedium16Primary = textMedium16.copyWith(color: textColorPrimary),
    textMedium16Secondary = textMedium16.copyWith(color: textColorSecondary),
    textMedium16Red = textMedium16.copyWith(color: textColorRed),
    textMedium16Error = textMedium16.copyWith(color: textColorError),
    textMedium20 = textMedium.copyWith(fontSize: 20.0),
    textMedium34 = textMedium.copyWith(fontSize: 34.0),
//Bold
    textBold = _text.copyWith(fontWeight: FontWeight.bold);
