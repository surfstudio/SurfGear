import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/repositories/todos_repository.dart';

import 'mocks/todos_storage_mock.dart';

void main() {
  group('TodosRepository', () {
    const todo = TodoEntity(
      id: 0,
      title: 'title',
      description: 'description',
      isCompleted: false,
    );

    const todos = [todo];

    final todosStorageMock = TodosStorageMock();
    when(() => todosStorageMock.todos).thenReturn([]);
    when(() => todosStorageMock.currentFilter).thenReturn(FilterType.all);
    late TodosRepository todosRepository;

    setUp(() {
      todosRepository = TodosRepository(todosStorageMock);
    });

    group('addTodo', () {
      test('call _todosStorage.addTodo', () {
        todosRepository.addTodo('title', 'description');
        verify(() => todosStorageMock.addTodo('title', 'description'));
      });

      test('send updated todosState', () {
        when(() => todosStorageMock.todos).thenReturn(todos);

        expectLater(todosRepository.todosState.stream, mayEmit(todos));

        todosRepository.addTodo('title', 'description');
      });
    });

    group('getTodo', () {
      test('return correct param', () {
        const todoId = 0;
        when(() => todosRepository.getTodo(any())).thenReturn(todo);

        expect(todosRepository.getTodo(todoId), todo);
      });
    });

    group('removeTodo', () {
      test('call _todosStorage.removeTodo', () {
        todosRepository.removeTodo(todo);
        verify(() => todosStorageMock.removeTodo(todo));
      });

      test('send updated todosState', () {
        when(() => todosStorageMock.todos).thenReturn(todos);

        expectLater(todosRepository.todosState.stream, mayEmit(todos));

        todosRepository.removeTodo(todo);
      });
    });

    group('setFilter', () {
      const filter = FilterType.all;
      test('call _todosStorage.setFilter', () {
        todosRepository.setFilter(filter);
        verify(() => todosStorageMock.setFilter(filter));
      });

      test('send updated todosState', () {
        when(() => todosStorageMock.todos).thenReturn(todos);

        expectLater(todosRepository.todosState.stream, mayEmit(todos));

        todosRepository.setFilter(filter);
      });

      test('send updated currentFilterState', () {
        when(() => todosStorageMock.currentFilter).thenReturn(filter);

        expectLater(todosRepository.currentFilterState.stream, emits(filter));

        todosRepository.setFilter(filter);
      });
    });

    group('updateTodo', () {
      test('call _todosStorage.updateTodo', () {
        todosRepository.updateTodo(todo);
        verify(() => todosStorageMock.updateTodo(todo));
      });

      test('send updated todosState', () {
        when(() => todosStorageMock.todos).thenReturn(todos);

        expectLater(todosRepository.todosState.stream, mayEmit(todos));

        todosRepository.updateTodo(todo);
      });

      test('send updated todosState when FilterType.completed', () {
        when(() => todosStorageMock.todos).thenReturn(todos);
        when(() => todosStorageMock.currentFilter).thenReturn(FilterType.completed);

        expectLater(todosRepository.todosState.stream, mayEmit(<TodoEntity>[]));

        todosRepository.updateTodo(todo);
      });

      test('send updated todosState when FilterType.acive', () {
        when(() => todosStorageMock.todos).thenReturn(todos);
        when(() => todosStorageMock.currentFilter).thenReturn(FilterType.active);

        expectLater(todosRepository.todosState.stream, mayEmit(todos));

        todosRepository.updateTodo(todo);
      });

      test('send updated todosState when FilterType.all', () {
        when(() => todosStorageMock.todos).thenReturn(todos);
        when(() => todosStorageMock.currentFilter).thenReturn(FilterType.all);

        expectLater(todosRepository.todosState.stream, mayEmit(todos));

        todosRepository.updateTodo(todo);
      });
    });
  });
}
