import 'package:test/test.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/storage/todos_storage.dart';

void main() {
  group('TodosStorage', () {
    TodosStorage todosStorage;
    const todo = TodoEntity(0, 'title', 'description', false);

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

      test('return null if storage not contains todoEntity with incorrect id', () {
        todosStorage.addTodo('title', 'description');
        expect(todosStorage.getTodo(1), isNull);
      });
    });

    group('removeTodo', () {
      test('correct remove todoEntity', () {
        todosStorage.addTodo('title', 'description');
        expect(todosStorage.todos.first, todo);
        todosStorage.removeTodo(todo);
        expect(todosStorage.getTodo(0), isNull);
      });
    });

    group('setFilter', () {
      test('set new filterType', () {
        final filter = FilterType.active;
        expect(todosStorage.currentFilter, FilterType.all);
        todosStorage.setFilter(filter);
        expect(todosStorage.currentFilter, filter);
      });
    });

    group('updateTodo', () {
      test('correct update todoEntity', () {
        const updatedTodo = TodoEntity(0, 'new title', '', true);

        todosStorage.addTodo('title', 'description');
        expect(todosStorage.todos.first, todo);
        todosStorage.updateTodo(updatedTodo);
        expect(todosStorage.todos.first, updatedTodo);
      });

      test('emit exception if todoEntity not found', () {
        expect(() => todosStorage.updateTodo(todo),
            throwsA(allOf(isException, predicate((e) => e.message == 'TODO id no found'))));
      });
    });
  });
}
