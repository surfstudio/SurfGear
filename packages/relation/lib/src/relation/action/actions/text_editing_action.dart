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
import 'package:relation/src/relation/action/action.dart';

/// Action for text editing
class TextEditingAction extends Action<String> {
  TextEditingAction([
    void Function(String data) onChanged,
  ]) : super(onChanged) {
    controller.addListener(() {
      accept(controller.value.text);
    });
  }

  /// TextEditing controller of text field
  final widgets.TextEditingController controller =
      ExtendedTextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// When updating text through the setter, moves the cursor to the end of the
/// line
class ExtendedTextEditingController extends widgets.TextEditingController {
  ExtendedTextEditingController({String text}) : super(text: text);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: widgets.TextSelection.collapsed(offset: newText.length),
      composing: widgets.TextRange.empty,
    );
  }
}
