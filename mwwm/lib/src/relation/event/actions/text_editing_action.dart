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

import 'package:flutter/widgets.dart' as widgets;

import 'package:mwwm/src/relation/event/action.dart';

/// Action for text editing
class TextEditingAction extends Action<String> {
  final widgets.TextEditingController controller =
      _ExtendedTextEditingController();

  TextEditingAction([void Function(String data) onChanged]) : super(onChanged) {
    controller.addListener(() {
      accept(controller.value.text);
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// При обновлении текста через сеттер переводит курсор на конец строки
class _ExtendedTextEditingController extends widgets.TextEditingController {
  _ExtendedTextEditingController({String text}) : super(text: text);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: widgets.TextSelection.collapsed(offset: newText.length),
      composing: widgets.TextRange.empty,
    );
  }
}
