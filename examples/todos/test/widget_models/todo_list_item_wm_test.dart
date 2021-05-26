import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/widgets/todo_list_item/todo_list_item_wm.dart';

import '../mocks/navigation_mock.dart';
import '../mocks/todos_repository_mock.dart';

void main() {
  group('TodoListItemWM', () {
    final todosRepositoryMock = TodosRepositoryMock();
    final navigationMock = NavigationMock();
    const todoId = 0;

    const todo = TodoEntity(
      id: todoId,
      title: 'title',
      description: 'description',
      isCompleted: false,
    );

    when(() => todosRepositoryMock.getTodo(todoId)).thenReturn(todo);
    late TodoListItemWM todoListItemWM;

    setUp(() {
      registerFallbackValue<TodoEntity>(todo);
      todoListItemWM =
          TodoListItemWM(navigationMock, todosRepositoryMock, todoId);
    });

    group('changeStatus()', () {
      test('call _todosRepository.updateTodo', () {
        todoListItemWM.changeStatus();

        verify(
          () => todosRepositoryMock.updateTodo(any(that: isA<TodoEntity>())),
        );
      });

      test('emit new todo state', () {
        expectLater(todoListItemWM.todoEntity.stream, mayEmit(<TodoEntity>[]));
        todoListItemWM.changeStatus();

        verify(() => todosRepositoryMock.getTodo(todoId));
      });
    });

    group('editTodo', () {
      test('call _navigation.showAddEditScreen', () {
        todoListItemWM.editTodo();
        verify(() => navigationMock.showAddEditScreen(
              todoEntity: any(
                named: 'todoEntity',
                that: isA<TodoEntity>(),
              ),
            ));
      });
    });
  });
}
