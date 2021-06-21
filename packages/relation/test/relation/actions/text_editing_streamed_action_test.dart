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

import 'package:flutter/widgets.dart' hide TextEditingAction;
import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  test('TextEditingAction test', () {
    final action = TextEditingAction(
      // ignore: deprecated_member_use_from_same_package
      onChanged: (data) {
        expect(data, equals('test'));
      },
    );
    action.controller.text = 'test';
  });

  test('TextEditingAction dispose test', () {
    final action = TextEditingAction()..dispose();
    expect((action.stream as Subject).isClosed, isTrue);
  });

  test('ExtendedTextEditingController setText({String text}) test', () {
    final TextEditingController controller = ExtendedTextEditingController()
      ..text = 'test';
    expect(controller.value.text, 'test');
    expect(
      controller.selection,
      const TextSelection.collapsed(offset: 'test'.length),
    );
    expect(controller.value.composing, TextRange.empty);
  });
}
