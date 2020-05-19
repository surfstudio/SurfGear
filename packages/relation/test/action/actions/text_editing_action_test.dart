import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';

void main() {
  test('TextEditingAction test', () {
    final action = TextEditingAction((onChanged) {
      expect('test', onChanged);
    });
    action.controller.text = 'test';
  });

  test('TextEditingAction dispose test', () {
    final action = TextEditingAction();
    action.dispose();
    expect(action.subject.isClosed, true);
  });

  test('ExtendedTextEditingController setText({String text}) test', () {
    final TextEditingController controller = ExtendedTextEditingController();
    controller.text = 'test';
    expect(controller.value.text, 'test');
    expect(
      controller.selection,
      TextSelection.collapsed(offset: 'test'.length),
    );
    expect(controller.value.composing, TextRange.empty);
  });
}
