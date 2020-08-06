// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
