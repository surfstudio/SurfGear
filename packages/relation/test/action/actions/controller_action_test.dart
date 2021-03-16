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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';

void main() {
  test('ControllerAction test', () {
    final textEditingController = TextEditingController();
    ControllerAction<dynamic, TextEditingController>(
      textEditingController,
      (controller, action) {
        expect(controller.runtimeType, TextEditingController);
        expect(controller.value.text, 'test');
      },
    );
    textEditingController.text = 'test';
  });

  test('ControllerAction call test', () {
    final textEditingController = TextEditingController();
    ControllerAction<dynamic, TextEditingController>(
      textEditingController,
      (controller, action) {
        expect(action.value.query, 'test');
      },
    ).call(const TextEditingValue(text: 'test'));
  });

  test('ControllerAction dispose test', () {
    final textEditingController = TextEditingController();
    final action = ControllerAction<dynamic, TextEditingController>(
      textEditingController,
      (controller, action) {},
    )..dispose();
    expect(action.process.isClosed, true);
  });
}
