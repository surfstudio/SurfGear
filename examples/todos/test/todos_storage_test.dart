import 'package:flutter_test/flutter_test.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/storage/todos_storage.dart';

void main() {
  group('TodosStorage', () {
    late TodosStorage todosStorage;
    const todo = TodoEntity(
      id: 0,
      title: 'title',
      description: 'description',
      isCompleted: false,
    );

    setUp(() {
      todosStorage = TodosStorage();
    });

    group('addTodo', () {
      test('add new correct TodoEntity', () {
        todosStorage.addTodo('title', 'description');
        expect(todosStorage.todos.first, todo);
      });
    });

    group('getTodo', () {
      test('return correct TodoEntity', () {
        todosStorage.addTodo('title', 'description');
        expect(todosStorage.getTodo(0), todo);
      });
    });

    group('removeTodo', () {
      test('correct remove todoEntity', () {
        todosStorage.addTodo('title', 'description');
        expect(todosStorage.todos.first, todo);
        todosStorage.removeTodo(todo);
        expect(todosStorage.todos.isEmpty, isTrue);
      });
    });

    group('setFilter', () {
      test('set new filterType', () {
        const filter = FilterType.active;
        expect(todosStorage.currentFilter, FilterType.all);
        todosStorage.setFilter(filter);
        expect(todosStorage.currentFilter, filter);
      });
    });

    group('updateTodo', () {
      test('correct update todoEntity', () {
        const updatedTodo =
            TodoEntity(id: 0, title: 'new title', isCompleted: true);

        todosStorage.addTodo('title', 'description');
        expect(todosStorage.todos.first, todo);
        todosStorage.updateTodo(updatedTodo);
        expect(todosStorage.todos.first, updatedTodo);
      });
    });
  });
}
