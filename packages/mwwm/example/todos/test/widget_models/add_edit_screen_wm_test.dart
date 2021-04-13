import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen_wm.dart';

import '../mocks/build_context_mock.dart';

void main() {
  group('AddEditScreenWM', () {
    AddEditScreenWM addEditScreenWM;
    BuildContextMock buildContextMock;
    GlobalKey<FormState> formKey;

    const todo = TodoEntity(
      0,
      'title',
      'description',
      false,
    );

    setUp(() {
      buildContextMock = BuildContextMock();
      when(() => buildContextMock.read<AppProvider>()).thenReturn(expected);

      formKey = GlobalKey<FormState>();

      addEditScreenWM = AddEditScreenWM(buildContextMock, todo, formKey);
    });

    group('isEditing', () {
      test('return true if TodoEntity is no null', () {
        expect(addEditScreenWM.isEditing, isTrue);
      });

      test('return false if TodoEntity is null', () {
        expect(AddEditScreenWM(buildContextMock, null, formKey), isFalse);
      });
    });
  });
}
