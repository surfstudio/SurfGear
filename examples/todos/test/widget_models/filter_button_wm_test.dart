import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/ui/widgets/filter_button/filter_button_wm.dart';

import '../mocks/todos_repository_mock.dart';

void main() {
  group('FilterButtonWM', () {
    final todosRepositoryMock = TodosRepositoryMock();

    late FilterButtonWM filterButtonWM;

    setUp(() {
      filterButtonWM = FilterButtonWM(todosRepositoryMock);
    });

    group('selectFilter', () {
      test('call _todosRepository.setFilter', () {
        const filter = FilterType.completed;

        filterButtonWM.selectFilter(filter);
        verify(() => todosRepositoryMock.setFilter(filter));
      });
    });
  });
}
