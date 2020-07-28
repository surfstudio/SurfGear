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
    expect(action.subject.isClosed, true);
  });
}
