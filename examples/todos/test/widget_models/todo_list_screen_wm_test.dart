import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/screens/todo_list_screen/todo_list_screen_wm.dart';

import '../mocks/navigation_mock.dart';
import '../mocks/todos_repository_mock.dart';

void main() {
  group('TodoListScreenWM', () {
    final todosRepositoryMock = TodosRepositoryMock();
    final navigationMock = NavigationMock();

    TodoListScreenWM todoListScreenWM = TodoListScreenWM(navigationMock, todosRepositoryMock);

    setUp(() {
      todoListScreenWM = TodoListScreenWM(
        navigationMock,
        todosRepositoryMock,
      );
    });

    group('addTodo', () {
      test('call _navigation.showAddEditScreen()', () {
        todoListScreenWM.addTodo();
        verify(navigationMock.showAddEditScreen);
      });
    });

    group('removeTodo', () {
      test('call removeTodo from _todosRepository', () {
        const todo = TodoEntity(
          id: 0,
          title: 'title',
          description: 'description',
          isCompleted: false,
        );

        todoListScreenWM.removeTodo(todo);
        verify(() => todosRepositoryMock.removeTodo(todo));
      });
    });
  });
}
