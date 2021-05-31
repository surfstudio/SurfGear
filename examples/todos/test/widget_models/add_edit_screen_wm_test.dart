import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen_wm.dart';

import '../mocks/navigation_mock.dart';
import '../mocks/todos_repository_mock.dart';

void main() {
  group('AddEditScreenWM', () {
    const todo = TodoEntity(
      id: 0,
      title: 'title',
      description: 'description',
      isCompleted: false,
    );

    final todosRepositoryMock = TodosRepositoryMock();
    final navigationMock = NavigationMock();

    late AddEditScreenWM addEditScreenWM;

    setUp(() {
      addEditScreenWM = AddEditScreenWM(
        navigationMock,
        todosRepositoryMock,
        todo,
      );

      registerFallbackValue<TodoEntity>(todo);
    });

    group('isEditing', () {
      test('return true if todoEntity is not null', () {
        expect(
          AddEditScreenWM(navigationMock, todosRepositoryMock, todo).isEditing,
          isTrue,
        );
      });

      test('return false if todoEntity is null', () {
        expect(
          AddEditScreenWM(navigationMock, todosRepositoryMock, null).isEditing,
          isFalse,
        );
      });
    });

    group('save', () {
      test('never call _todosRepository if is not valid', () {
        addEditScreenWM.save(isValid: false);
        verifyNever(() => todosRepositoryMock.addTodo(any(), any()));
        verifyNever(() => todosRepositoryMock.updateTodo(any()));
      });

      test('if isEditing then call updateTodo and naviagtion back', () {
        addEditScreenWM.save(isValid: true);
        verify(
          () => todosRepositoryMock.updateTodo(any(that: isA<TodoEntity>())),
        );
        verify(navigationMock.back);
      });

      test('if no isEditing then call addTodo and naviagtion back', () {
        AddEditScreenWM(navigationMock, todosRepositoryMock, null)
            .save(isValid: true);

        verify(() => todosRepositoryMock.addTodo('', ''));
        verify(navigationMock.back);
      });
    });
  });
}
